extern crate structopt;
#[macro_use]
extern crate structopt_derive;
extern crate dirs;
extern crate shell_escape;
extern crate ansi_term;
extern crate mio;
extern crate mio_uds;
extern crate mio_extras;

use std::os::unix::net::{UnixStream};
use std::process::Command;
use std::thread::sleep;
use std::time::Duration;
use std::io::Write;
use mio::unix::EventedFd;
use std::os::unix::io::{FromRawFd};
use ansi_term::Colour::Yellow;
use std::io::Read;

mod opts {
    use ::structopt::clap::AppSettings;
    use ::structopt::StructOpt;

    #[derive(Debug, StructOpt)]
    pub struct Server {
        #[structopt(long = "stdin", short = "-i")]
        pub stdin: bool,

        #[structopt(name = "name")]
        pub name: String,

        pub params: Vec<String>,
    }

    #[derive(Debug, StructOpt)]
    pub struct Client {
        #[structopt(name = "address")]
        pub name: String,
    }

    #[derive(Debug, StructOpt)]
    pub enum Command {
        #[structopt(name = "wait-on")]
        Server(Server),

        #[structopt(name = "signal")]
        Client(Client),
    }

    #[derive(StructOpt, Debug)]
    #[structopt(raw(
        global_settings = "&[AppSettings::ColoredHelp]"
    ))]
    pub struct Opt {
        #[structopt(subcommand)]
        pub command: Command,
    }

    pub fn get_opts() -> Opt {
        Opt::from_args()
    }
}

struct TerminalSettings {
    settings: String,
}

impl TerminalSettings {
    fn save() -> Self {
        let mut command = std::process::Command::new("stty");
        let output = command.args(&["-g"])
                .stdin(std::process::Stdio::inherit())
                .stderr(std::process::Stdio::inherit());
        let output = output.output();
        let stdout = output.expect("stty output").stdout;
        let string = String::from_utf8_lossy(&stdout[..]);
        let trimmed = string.trim();

        TerminalSettings {
            settings: String::from(trimmed),
        }
    }

    fn restore(&self) {
        let mut command = std::process::Command::new("stty");
        let _ = command.args(&[self.settings.clone()])
                .stdout(std::process::Stdio::inherit())
                .stdin(std::process::Stdio::inherit())
                .stderr(std::process::Stdio::inherit()).status();
    }
}

fn wait_child(mut child: std::process::Child, receiver: std::sync::mpsc::Receiver<()>,
              chan_sender: mio_extras::channel::Sender<()>) {
    let id = child.id();

    loop {
        match child.try_wait() {
            Ok(Some(status)) => {
                println!("");
                println!("< {} >", Yellow.paint(format!("{}", status)));
                chan_sender.send(()).unwrap();
                sleep(Duration::from_millis(100));
                break;
            }
            Ok(None) => {
                match receiver.try_recv() {
                    Ok(()) => {
                        let _ = child.kill();
                    }
                    _ => {}
                }
                sleep(Duration::from_millis(10));
            }
            Err(err) => {
                println!("< {} >",
                         Yellow.paint(format!("error {:?} waiting for pid {}", err, id)));
                sleep(Duration::from_millis(500));
            }
        }
    }
}

struct Child {
    thread: Option<(std::thread::JoinHandle<()>, std::sync::mpsc::Sender<()>)>,
    params: Vec<String>,
    chan_sender: mio_extras::channel::Sender<()>,
}

impl Child {
    fn banner(&self) {
        print!("[ ");
        let mut i = 0;
        for arg in &self.params {
            if i != 0 {
                print!(" ");
            }
            i = i + 1;
            print!("{}",
                   Yellow.paint(shell_escape::escape(std::borrow::Cow::Borrowed(arg))));
        }
        println!(" ]");
    }

    fn try_kill(&mut self) -> bool {
        if let Some((_, sender)) = &self.thread {
            let _ = sender.send(());
            false
        } else {
            true
        }
    }

    fn collect(&mut self) {
        if let Some((thread, _)) = self.thread.take() {
            thread.join().expect("child thread panicked");
        }
    }

    fn spawn(&mut self) -> bool {
        if self.thread.is_some() {
            panic!("unexpected thread state");
        }

        println!("< {} >", Yellow.paint(format!("...")));

        let (sender, receiver) = std::sync::mpsc::channel();
        let params = self.params.clone();
        let chan_sender = self.chan_sender.clone();

        let joiner = std::thread::spawn(|| {
            let params = params;
            let mut command = Command::new(&params[0]);
            let command = command.args(&params[1..])
                .stdout(std::process::Stdio::inherit())
                .stdin(std::process::Stdio::inherit())
                .stderr(std::process::Stdio::inherit());
            let child = command.spawn().unwrap();
            wait_child(child, receiver, chan_sender);
        });

        self.thread = Some((joiner, sender));
        true
    }
}

fn main() {
    let opts = opts::get_opts();
    let home_dir = dirs::home_dir().unwrap();
    let socket_path = |name: &str| {
        let name = format!(".rex-{}", name);
        home_dir.join(name)
    };

    let terminal_settings = TerminalSettings::save();

    match opts.command {
        opts::Command::Server(server) => {
            let path = socket_path(&server.name);
            let _ = std::fs::remove_file(&path);

            let (chan_sender, chan_receiver) = mio_extras::channel::channel();
            let mut child = Child { thread : None, params: server.params.clone(),
            chan_sender };

            let listener = mio_uds::UnixListener::bind(path).unwrap();
            let poll = mio::Poll::new().unwrap();
            let mut events = mio::Events::with_capacity(32);
            poll.register(&listener, mio::Token(1), mio::Ready::readable(), mio::PollOpt::edge()).unwrap();

            let mut fd0 : std::fs::File = unsafe { FromRawFd::from_raw_fd(0) };

            let efd = EventedFd(&0);
            let mut child_kill_pending = false;
            let mut efs_registered = true;
            poll.register(&efd, mio::Token(2), mio::Ready::readable(), mio::PollOpt::edge()).unwrap();

            poll.register(&chan_receiver, mio::Token(3), mio::Ready::readable(), mio::PollOpt::edge()).unwrap();

            child.banner();

            loop {
                let _ = poll.poll(&mut events, None);

                for event in &events {
                    match event.token() {
                        mio::Token(1) => {
                            let _socket = listener.accept();
                            if !server.stdin && efs_registered {
                                poll.deregister(&efd).unwrap();
                                efs_registered = false;
                            }

                            if child.try_kill() {
                                child.spawn();
                            } else {
                                child_kill_pending = true;
                            }
                        }
                        mio::Token(2) => {
                            let mut buf = vec![0; 0x1000];
                            let len = fd0.read(&mut buf[..]).unwrap();
                            let mut has_newline = false;

                            for i in &buf[0 .. len] {
                                if *i == 10 {
                                    has_newline = true;
                                }
                            }

                            if has_newline {
                                if !server.stdin && efs_registered {
                                    poll.deregister(&efd).unwrap();
                                    efs_registered = false;
                                }
                                if child.try_kill() {
                                    child.spawn();
                                } else {
                                    child_kill_pending = true;
                                }
                            }
                        }
                        mio::Token(3) => {
                            // Child died
                            while let Ok(_) = chan_receiver.try_recv() {}
                            child.collect();

                            terminal_settings.restore();

                            if !server.stdin && !efs_registered && !child_kill_pending {
                                poll.register(&efd, mio::Token(2),
                                    mio::Ready::readable(), mio::PollOpt::edge()).unwrap();
                                efs_registered = true;
                            }
                            child.banner();

                            if child_kill_pending {
                                child.spawn();
                                child_kill_pending = false;
                            }
                        }
                        _ => {
                        }
                    }
                }
            }
        }
        opts::Command::Client(client) => {
            let fd = UnixStream::connect(socket_path(&client.name));
            match fd {
                Ok(mut fd) => {
                    fd.write("restart".as_bytes()).unwrap();
                },
                Err(_) => {}
            }
        }
    }
}
