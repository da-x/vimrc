use std::io::Read;
use std::io::Write;
use std::os::unix::io::AsRawFd;
use std::os::unix::io::{FromRawFd};
use std::os::unix::net::{UnixStream};
use std::path::PathBuf;
use std::process::Command;
use std::thread::sleep;
use std::time::Duration;

use ansi_term::Colour::Yellow;
use mio::unix::EventedFd;


mod opts {
    use structopt::StructOpt;
    use std::path::PathBuf;

    #[derive(Debug, StructOpt)]
    pub struct Server {
        #[structopt(long = "stdin", short = "i")]
        pub stdin: bool,

        #[structopt(long = "name", short = "n")]
        pub name: Option<String>,

        #[structopt(long = "git", short = "g")]
        pub git_path: Option<PathBuf>,

        #[structopt(long = "clear-before-exec", short = "c")]
        pub clear_before_exec: bool,

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
    clear_before_exec: bool,
}

impl Child {
    fn banner(
        &self,
        title: &str,
        git_path: &Option<PathBuf>,
        name: &Option<String>,
    ) {
        print!("[ {}:", title);

        if let Some(name) = name {
            print!(" channel {}", name);
        }

        if let Some(git_path) = git_path {
            print!(" git path `{}`", git_path.to_str().unwrap());
        }

        print!(" to execute `");
        let mut i = 0;
        for arg in &self.params {
            if i != 0 {
                print!(" ");
            }

            i = i + 1;
            print!("{}",
                   Yellow.paint(shell_escape::escape(std::borrow::Cow::Borrowed(arg))));
        }
        println!("` ]");
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

        if self.clear_before_exec {
            let _ = crossterm::execute!(
                std::io::stdout(),
                crossterm::terminal::Clear(crossterm::terminal::ClearType::All),
                crossterm::cursor::MoveTo(0, 0),
            );
            self.banner("executing", &None, &None);
        } else {
            println!("< {} >", Yellow.paint(format!("...")));
        }

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

fn create_inotify(
    path: &PathBuf,
) -> inotify::Inotify {
    use inotify::WatchMask;

    let mut vec = Vec::new();

    vec.push(String::from(path.to_str().unwrap()));

    for command in &["git ls-files", "git ls-untracked"] {
        let shell =
            format!("cd {} && {}", path.to_str().unwrap(), command);
        let output = Command::new("bash")
            .args(&["-c", &shell]).output().unwrap();
        let lines = String::from_utf8(output.stdout).unwrap();
        for line in lines.split("\n").into_iter() {
            vec.push(String::from(line));
        }
    }

    let mut inotify = inotify::Inotify::init().expect("inotify");

    for h in vec.into_iter() {
        if h.len() > 0 {
            let path = path.join(h);

            inotify.add_watch(path,
                WatchMask::MODIFY |
                WatchMask::DELETE_SELF |
                WatchMask::CREATE |
                WatchMask::MOVE_SELF |
                WatchMask::MOVED_FROM |
                WatchMask::MOVED_TO
                ).expect("Failed to add file watch");
        }
    }

    inotify
}

fn update_inotify(
    poll: &mio::Poll,
    path: &Option<PathBuf>,
    inotify: &mut Option<inotify::Inotify>,
) {
    if let Some(path) = &path {
        if let Some(notify) = inotify {
            poll.deregister(
                &EventedFd(&notify.as_raw_fd()),
            ).unwrap();
        }

        let notify = create_inotify(path);

        poll.register(
            &EventedFd(&notify.as_raw_fd()),
            mio::Token(4),
            mio::Ready::readable(),
            mio::PollOpt::edge(),
        ).unwrap();

        *inotify = Some(notify);
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
            if server.params.len() <= 1 {
                eprintln!("Command not specified");
                return;
            }

            let listener = if let Some(path) = &server.name {
                let path = socket_path(path);
                let _ = std::fs::remove_file(&path);
                let listener = mio_uds::UnixListener::bind(path).unwrap();
                Some(listener)
            } else {
                None
            };

            let (chan_sender, chan_receiver) = mio_extras::channel::channel();
            let mut child = Child {
                thread : None, params: server.params.clone(), chan_sender,
                clear_before_exec: server.clear_before_exec,
            };

            let poll = mio::Poll::new().unwrap();
            let mut events = mio::Events::with_capacity(32);

            if let Some(listener) = &listener {
                poll.register(
                    listener,
                    mio::Token(1),
                    mio::Ready::readable(),
                    mio::PollOpt::edge(),
                ).unwrap();
            }

            let mut fd0 : std::fs::File = unsafe { FromRawFd::from_raw_fd(0) };

            let efd = EventedFd(&0);
            let mut child_kill_pending = false;
            let mut efs_registered = true;
            poll.register(&efd, mio::Token(2), mio::Ready::readable(), mio::PollOpt::edge()).unwrap();

            poll.register(&chan_receiver, mio::Token(3), mio::Ready::readable(), mio::PollOpt::edge()).unwrap();

            child.banner("waiting on", &server.git_path, &server.name);

            let mut inotify = None;
            update_inotify(&poll, &server.git_path, &mut inotify);

            loop {
                let _ = poll.poll(&mut events, None);
                let mut respawn = false;

                for event in &events {
                    match event.token() {
                        mio::Token(1) => {
                            if let Some(listener) = &listener {
                                let _socket = listener.accept();
                            }

                            respawn = true;
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
                                respawn = true;
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

                            child.banner("waiting on", &server.git_path, &server.name);

                            if child_kill_pending {
                                child.spawn();
                                child_kill_pending = false;
                            }
                        }
                        mio::Token(4) => {
                            respawn = true;
                            update_inotify(&poll, &server.git_path, &mut inotify);
                        }
                        _ => {}
                    }
                }

                if respawn {
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
