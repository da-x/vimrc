extern crate structopt;
#[macro_use]
extern crate structopt_derive;
extern crate dirs;
extern crate shell_escape;
extern crate ansi_term;

use std::os::unix::net::{UnixStream, UnixListener};
use std::process::Command;
use std::thread::sleep;
use std::time::Duration;
use std::io::Write;
use ansi_term::Colour::Yellow;

mod opts {
    use ::structopt::clap::AppSettings;
    use ::structopt::StructOpt;

    #[derive(Debug, StructOpt)]
    pub struct Server {
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

fn main() {
    let opts = opts::get_opts();
    let home_dir = dirs::home_dir().unwrap();
    let socket_path = |name: &str| {
        let name = format!(".rex-{}", name);
        home_dir.join(name)
    };

    match opts.command {
        opts::Command::Server(server) => {
            let path = socket_path(&server.name);
            let _ = std::fs::remove_file(&path);

            let f = || {
                print!("[ ");
                let mut i = 0;
                for arg in &server.params {
                    if i != 0 {
                        print!(" ");
                    }
                    i = i + 1;
                    print!("{}",
                           Yellow.paint(shell_escape::escape(std::borrow::Cow::Borrowed(arg))));
                }
                print!(" ]");
                std::io::stdout().flush().unwrap();
            };

            f();

            let listener = UnixListener::bind(path).unwrap();
            for stream in listener.incoming() {
                println!();
                match stream {
                    Ok(_) => {
                        println!("< {} >", Yellow.paint(format!("...")));
                        let mut command = Command::new(&server.params[0]);
                        let command = command.args(&server.params[1..]);
                        let status = command.status();
                        match status {
                            Ok(status) => {
                                println!("");
                                println!("< {} >", Yellow.paint(format!("{}", status)));
                                if !status.success() {
                                    sleep(Duration::from_millis(1000));
                                }
                            }
                            Err(_) => {
                                sleep(Duration::from_millis(1000));
                            }
                        }
                    }
                    Err(_) => {
                        break;
                    }
                }
                f();
            }
            println!();
        }
        opts::Command::Client(client) => {
            let _ = UnixStream::connect(socket_path(&client.name));
        }
    }
}
