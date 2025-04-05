// With some code from https://github.com/doy/pty-process/blob/main/examples/tokio.rs
//
use std::{collections::BTreeMap, convert::Infallible, os::unix::process::ExitStatusExt, path::PathBuf, process::ExitStatus, sync::Arc};
use ansi_parser::{AnsiParser, AnsiSequence};
use crossterm::event::{Event, KeyCode, KeyEventKind};
use event::{EventHandler, ProgramEvent};
use futures::{FutureExt, SinkExt, StreamExt};
use hyper::service::{make_service_fn, service_fn};
use hyperlocal::UnixServerExt;
use keyaction::{EventVector, KeyTree};
use ratatui::{layout::{Constraint, Layout, Rect}, style::{Color, Modifier, Style, Stylize}};
use regex::Regex;
use serde::{Serialize, Deserialize};
use structopt::StructOpt;
use tokio::{io::AsyncReadExt as _, sync::{mpsc, Mutex}};
use anyhow::{bail, Context as AnyhowContext};

mod event;
mod keyaction;

type Term = ratatui::Terminal<ratatui::prelude::CrosstermBackend<std::io::Stdout>>;

impl Main {
    pub async fn run(&mut self) -> anyhow::Result<()> {
        self.start_proc().await?;
        self.start_server().await?;

        let terminal = ratatui::init();

        let res = self.in_loop(terminal).await;

        ratatui::restore();

        if let Err(e) = &res {
            for (idx, sub ) in e.chain().enumerate() {
                println!("Err {}: {:?}", idx, sub);
            }
        }

        res
    }

    pub async fn start_proc(&mut self) -> anyhow::Result<()> {
        let dims = match termion::terminal_size() {
            Ok(r) => r,
            Err(_) => bail!("not a terminal"),
        };

        let (mut pty, pts) = pty_process::open()?;
        pty.resize(pty_process::Size::new(dims.1, dims.0))?;
        let mut child = pty_process::Command::new(&self.cmd[0])
            .current_dir(self.parsed_opts.exec_cwd.clone())
            .args(&self.cmd[1..])
            .spawn(pts)?;

        self.running = true;

        let tx = self.program_update_tx.clone();

        tokio::spawn(async move {
            let mut out_buf = [0_u8; 0x10000];

            // If we want to relay stdin:
            //
            // pty.write_all(&in_buf[..bytes]).await.unwrap();

            let mut io_err = false;
            let mut exit = false;
            loop {
                tokio::select! {
                    bytes = pty.read(&mut out_buf) => match bytes {
                        Ok(bytes) => {
                            tx.send(ProgramUpdate::Data(Vec::from(&out_buf[..bytes]))).await?;
                            // stdout.write_all(&out_buf[..bytes]).await.unwrap();
                            // stdout.flush().await.unwrap();
                        }
                        Err(_) => {
                            io_err = true;
                            break;
                        }
                    },
                    e = child.wait() => {
                        match e {
                            Ok(v) => {
                                tx.send(ProgramUpdate::ExitStatus(v)).await?;
                                exit = true;
                                break;
                            },
                            Err(e) => {
                                tx.send(ProgramUpdate::Abnormal(format!("cannot wait: {:?}", e))).await?;
                                exit = true;
                                break;
                            },
                        }
                    },
                }
            }

            if io_err && !exit {
                loop {
                    tokio::select! {
                        e = child.wait() => {
                            match e {
                                Ok(v) => {
                                    tx.send(ProgramUpdate::ExitStatus(v)).await?;
                                    break;
                                },
                                Err(e) => {
                                    tx.send(ProgramUpdate::Abnormal(format!("cannot wait: {:?}", e))).await?;
                                    break;
                                },
                            }
                        },
                    }
                }
            } else if !io_err && exit {
                loop {
                    tokio::select! {
                        bytes = pty.read(&mut out_buf) => match bytes {
                            Ok(bytes) => {
                                tx.send(ProgramUpdate::Data(Vec::from(&out_buf[..bytes]))).await?;
                            }
                            Err(_) => {
                                break;
                            }
                        },
                    }
                }
            }

            anyhow::Ok(())
        });

        Ok(())
    }

    async fn do_action(&mut self, action: Action) -> anyhow::Result<()> {
        match action {
            Action::Exit => {
            },
            Action::Redraw => {
            },
            Action::NextMatch => {
                let selected_match = self.selected_match;

                match self.selected_match {
                    Some(x) => {
                        let next = (x + 1).min(self.found_matches.len().saturating_sub(1));
                        if next < self.found_matches.len() {
                            self.selected_match = Some(next);
                        } else {
                            self.selected_match = None;
                        }
                    },
                    None => {
                        if self.found_matches.len() > 0 {
                            self.selected_match = Some(0);
                        }
                    },
                }

                if selected_match != self.selected_match {
                    self.send_selected_match().await?;
                }
            },
            Action::PrevMatch => {
                let selected_match = self.selected_match;

                match self.selected_match {
                    Some(x) => {
                        self.selected_match = None;
                        let prev = x.saturating_sub(1);
                        if prev < self.found_matches.len() {
                            self.selected_match = Some(prev);
                        }
                    },
                    None => {
                        if self.found_matches.len() > 0 {
                            self.selected_match = Some(0);
                        }
                    },
                }

                if selected_match != self.selected_match {
                    self.send_selected_match().await?;
                }
            },
            Action::FirstMatch => {
                let selected_match = self.selected_match;

                let next = 0;
                if next < self.found_matches.len() {
                    self.selected_match = Some(next);
                } else {
                    self.selected_match = None;
                }

                if selected_match != self.selected_match {
                    self.send_selected_match().await?;
                }
            },
            Action::Redo => {
                self.running = false;
                self.no_color_output.clear();
                self.no_color_output_scan = 0;
                self.no_color_line_offset_to_idx = vec![(0, 0)].into_iter().collect();
                self.no_color_lines = 1;
                self.exit = Default::default();
                self.line_offsets = vec![0];
                self.output_line_scan = 0;
                self.raw_output.clear();
                self.unexpected = "".to_owned();
                self.output_regex_scan = 0;
                self.found_matches.clear();
                self.selected_match = None;
                self.start_proc().await?;
            },
        }

        Ok(())
    }

    async fn new_data(&mut self, data: Vec<u8>) -> anyhow::Result<()> {
        self.raw_output += &*String::from_utf8_lossy(&data);
        let selected_match = self.selected_match;

        while self.output_line_scan < self.raw_output.len() {
            let rest = &self.raw_output[self.output_line_scan..];
            if let Some(pos) = rest.find('\n') {
                let pos = self.output_line_scan + pos + 1;
                self.line_offsets.push(pos);
                for item in self.raw_output[self.output_line_scan .. pos].ansi_parse() {
                    match item {
                        ansi_parser::Output::TextBlock(text) => {
                            let mut text = Vec::from(text.as_bytes());
                            text.retain(|x| *x != 0x0d);
                            self.no_color_output += &String::from_utf8_lossy(&text.as_ref());
                        },
                        ansi_parser::Output::Escape(_) => {}
                    }
                }
                self.output_line_scan = pos;
            } else {
                self.output_line_scan = self.raw_output.len();
            }
        }

        while self.no_color_output_scan < self.no_color_output.len() {
            let rest = &self.no_color_output[self.no_color_output_scan..];
            if let Some(pos) = rest.find('\n') {
                let pos = self.no_color_output_scan + pos + 1;
                self.no_color_lines += 1;
                self.no_color_line_offset_to_idx.insert(pos, self.no_color_lines - 1);
                self.no_color_output_scan = pos;
            } else {
                self.no_color_output_scan = self.no_color_output.len();
            }
        }

        while self.output_regex_scan < self.no_color_output.len() {
            let rest = &self.no_color_output[self.output_regex_scan..];
            let mut last_match_end = 0;

            for regex in self.matchers.iter() {
                for cap in regex.1.captures_iter(rest) {
                    let all = cap.get(0);
                    let filename = cap.name("filename");
                    let line = cap.name("line");

                    if let (Some(line), Some(filename), Some(all)) =
                        (line, filename, all)
                    {
                        last_match_end = all.end().max(last_match_end);
                        let start_offset = self.output_regex_scan + all.start();
                        let end_offset = self.output_regex_scan + all.start();
                        let r =
                            self.no_color_line_offset_to_idx.range(start_offset..=end_offset).nth(0);
                        let start_line_idx = *(r.map(|x| x.1).unwrap_or(&0));
                        let r =
                            self.no_color_line_offset_to_idx.range(start_offset..=end_offset).last();
                        let end_line_idx = *(r.map(|x| x.1).unwrap_or(&0)) + 1;

                        self.found_matches.push(Match {
                            match_kind: regex.0,
                            start_line_idx,
                            end_line_idx,
                            file_name: filename.as_str().to_owned(),
                            file_line: line.as_str().to_owned().parse()
                                .with_context(|| format!("String: {:?}", line))?,
                        });

                        if self.selected_match.is_none() {
                            self.selected_match = Some(0);
                        }
                    }
                }
            }

            if last_match_end == 0 {
                self.output_regex_scan = self.output_regex_scan.max(
                    self.no_color_output.len().saturating_sub(0x1000));
                break;
            }

            self.output_regex_scan += last_match_end;
        }

        if selected_match != self.selected_match {
            self.send_selected_match().await?;
        }

        Ok(())
    }

    pub async fn in_editor_update(&mut self, x: EditorUpdate) -> anyhow::Result<()> {
        match x {
            EditorUpdate::Bind(sender, ack) => {
                self.controller_tx = Some(sender);
                self.shared.lock().await.bound = true;
                tokio::spawn(async move {
                    let _ = ack.send(()).await;
                });
            },
            EditorUpdate::Unbind => {
                self.controller_tx = None;
                self.shared.lock().await.bound = false;
            }
            EditorUpdate::Next => {
                self.do_action(Action::NextMatch).await?;
            },
            EditorUpdate::Prev => {
                self.do_action(Action::PrevMatch).await?;
            },
            EditorUpdate::First => {
                self.do_action(Action::FirstMatch).await?;
            },
            EditorUpdate::Redo => {
                self.do_action(Action::Redo).await?;
            },
        }

        Ok(())
    }

    pub async fn in_program_update(&mut self, x: ProgramUpdate) -> anyhow::Result<()> {
        match x {
            ProgramUpdate::Data(data) => {
                self.new_data(data).await?;
            },
            ProgramUpdate::ExitStatus(exit_status) => {
                self.exit = exit_status;
                self.running = false;
            },
            ProgramUpdate::Abnormal(status) => {
                if self.running {
                    self.unexpected = format!("abnormal: {}", status);
                }
            }
        }

        Ok(())
    }

    pub async fn in_loop(&mut self, mut term: Term) -> anyhow::Result<()> {
        let mut events = EventHandler::new(1000);

        'out: loop {
            term.draw(|frame| {
                let _ = self.draw(frame);
            })?;

            tokio::select! {
                rx = self.program_update_rx.recv() => {
                    match rx {
                        Some(x) => self.in_program_update(x).await?,
                        None => {
                            self.unexpected = String::from("no progrqm_update_rx");
                            break;
                        },
                    }
                }
                rx = self.editor_update_rx.recv() => {
                    match rx {
                        Some(x) => self.in_editor_update(x).await?,
                        None => {
                            self.unexpected = String::from("no editor_update_rx");
                            break;
                        }
                    }
                }
                event = events.next() => {
                    match event {
                        Ok(event) => {
                            if let Some(action) = self.event_to_action(event)? {
                                match action {
                                    Action::Exit => {
                                        break 'out;
                                    }
                                    _ => {}
                                }

                                // TODO: handle error
                                let _ = self.do_action(action).await;
                            }
                        }
                        Err(_) => {
                            break 'out;
                        }
                    }
                }
            }
        }

        Ok(())
    }

    fn draw(&self, frame: &mut ratatui::Frame<'_>) {
        let area = frame.area();
        let screen_width = area.width as usize;
        if screen_width < 1 {
            return;
        }

        // Draw title
        let buf = frame.buffer_mut();
        let cmd = self.cmd.join(" ").chars().collect::<Vec<_>>();
        let command_lines = (cmd.len() + screen_width - 1) / screen_width;

        let vertical_items = vec![
            Constraint::Length(command_lines as u16), // Title section
            Constraint::Min(1), // Middle section
            Constraint::Length(1) // Footer
        ];

        let title_style = Style::new().fg(Color::White).bg(Color::Rgb(0, 0, 230));
        for i in 0..command_lines {
            let part = &cmd[i * screen_width..];
            let part = &part[..screen_width.min(part.len())];
            let part = part.iter().collect::<String>();
            let part = format!("{:<width$}!", part, width=screen_width);
            buf.set_string(0, i as u16, part, title_style);
        }

        let rects = Layout::vertical(vertical_items).split(area);

        let horizontal_items = vec![
            Constraint::Length(1), // Sign bar
            Constraint::Min(1), // Middle section
        ];

        let middle_section_rect = (*rects)[1];
        let middle_rects = Layout::horizontal(horizontal_items).split(middle_section_rect);
        let middle_section_rect = middle_rects[1];

        let mut middle_print_offset: i16 = 0;
        let current_match = match self.selected_match {
            Some(idx) => self.found_matches.get(idx),
            None => None,
        };

        let (reversed_print, mut line_idx ) = match current_match {
            Some(current_match) => {
                (false, current_match.start_line_idx.saturating_sub(1))
            },
            None => {
                (true, self.line_offsets.len().saturating_sub(1))
            },
        };

        let mut total_line_heights = 0;
        let mut lines_printed = vec![];
        while middle_print_offset < middle_section_rect.height as i16 {
            let content = if let Some(s) = self.get_line(line_idx) {
                s
            } else {
                break;
            };

            let selected = match current_match {
                Some(current_match) => {
                    line_idx >= current_match.start_line_idx &&
                    line_idx <= current_match.end_line_idx
                },
                None => false,
            };

            let split_height = draw_line(buf, middle_print_offset, middle_section_rect, content, selected);
            middle_print_offset += split_height as i16;
            if reversed_print {
                total_line_heights += split_height;
                lines_printed.push((content, selected));
                if line_idx == 0 {
                    break;
                }
                line_idx = line_idx - 1;
            } else {
                line_idx += 1;
            }
        }

        if reversed_print {
            middle_print_offset = (middle_section_rect.height as i16 - total_line_heights as i16).min(0);
            for (content, selected) in lines_printed.iter().rev() {
                middle_print_offset += draw_line(buf,
                    middle_print_offset, middle_section_rect, *content, *selected) as i16;
            }

            while middle_print_offset < middle_section_rect.height as i16 {
                middle_print_offset += draw_line(buf, middle_print_offset, middle_section_rect, "", false) as i16;
            }
        }

        let buf = frame.buffer_mut();
        let (mut status, status_style) = if self.running {
            ("Running".to_owned(), Style::new().fg(Color::Rgb(255, 128, 255)).bg(Color::Rgb(80, 0, 80)))
        } else {
            if self.exit.success() {
                ("OK".to_owned(), title_style)
            } else {
                (format!("Code {}", self.exit.code().unwrap_or(0)),
                    Style::new().fg(Color::Rgb(255, 255, 255)).bg(Color::Rgb(80, 0, 0)))
            }
        };

        if self.unexpected.len() > 0 {
            status = format!("Unexpected: {}", self.unexpected);
        }

        let mut extra = vec![];
        let nr_errors = self.found_matches.iter().filter(
            |x| x.match_kind == MatchKind::Error).count();
        let nr_warnings = self.found_matches.iter().filter(
            |x| x.match_kind == MatchKind::Warning).count();

        if self.controller_tx.is_some() {
            extra.push(format!("🔌"));
        } else {
            extra.push(format!("🚫"));
        }

        if nr_errors > 0 {
            extra.push(format!("errors: {}", nr_errors));
        }
        if nr_warnings > 0 {
            extra.push(format!("warnings: {}", nr_warnings));
        }

        let status = format!("{} | {} lines | {}",
            status, self.line_offsets.len(), extra.join(" | "));

        let status = &status[..screen_width.min(status.len())];
        let part = format!("{:<width$}!", status, width=screen_width);
        buf.set_string(0, rects[2].y, part, status_style);
    }

    fn get_line(&self, idx: usize) -> Option<&str> {
        let s = self.line_offsets.get(idx);
        let e = self.line_offsets.get(idx + 1);
        match (s, e) {
            (Some(s), None) => {
                return Some(&self.raw_output[*s..]);
            },
            (Some(s), Some(e)) => {
                return Some(&self.raw_output[*s..*e - 1]);
            },
            _ => return None,
        }
    }

    fn event_to_action(&mut self, event: ProgramEvent) -> anyhow::Result<Option<Action>> {
        let event = match event {
            ProgramEvent::Crossterm(Event::Resize(_, _)) => return Ok(Some(Action::Redraw)),
            e => e,
        };

        match &self.mode {
            Mode::Normal => self.event_to_action_normal_mode(event),
        }
    }

    fn event_to_action_normal_mode(&mut self, event: ProgramEvent) -> anyhow::Result<Option<Action>> {
        if let ProgramEvent::Crossterm(Event::Key(key)) = event {
            if key.kind == KeyEventKind::Press {
                if let Some(action) = self.key_accum.accum_get(&Main::default_key_actions()).get_action(key) {
                    return Ok(Some(action.clone()));
                }
            }
        }

        return Ok(None);
    }

    fn default_key_actions() -> KeyTree<Action> {
        let mut key_tree = KeyTree::new();

        key_tree.add_no_mods(KeyCode::Char('q'), Action::Exit);
        key_tree.add_no_mods(KeyCode::Enter, Action::Redo);
        key_tree.add_no_mods(KeyCode::Down, Action::NextMatch);
        key_tree.add_no_mods(KeyCode::Home, Action::FirstMatch);
        key_tree.add_no_mods(KeyCode::Up, Action::PrevMatch);
        key_tree.add_no_mods(KeyCode::Esc, Action::Exit);

        key_tree
    }

    pub async fn start_server(&mut self) -> anyhow::Result<()> {
        use hyper::{Body, Request, Response, StatusCode};

        pub const WEBSOCKET_PATH: &'static str = "/ws";

        fn handle_websocket_connection(
            context: &Context,
            req: Request<Body>,
            rsp: &mut Response<Body>,
        ) -> Result<(), anyhow::Error> {
            let mut req = req;
            let (response, stream) = hyper_tungstenite::upgrade(&mut req, None)?;
            *rsp = response;

            let context = context.clone();

            tokio::spawn(async move {
                if let Ok(mut stream) = stream.await {
                    let (tx_events, mut rx_events) =
                        tokio::sync::mpsc::channel(10);
                    let mut editor = Editor { bound: true };

                    loop {
                        tokio::select! {
                            from_editor = stream.next() => {
                                if let Some(Ok(msg)) = from_editor {
                                    match msg {
                                        tokio_tungstenite::tungstenite::Message::Text(text) => {
                                            if let Ok(x) = serde_json::from_str(&text) {
                                                if let Ok(rsp) = context.editor_message(x, &tx_events, &mut editor).await {
                                                    if let Ok(x) = serde_json::to_string(&rsp) {
                                                        let _ = stream.send(tokio_tungstenite::tungstenite::Message::Text(x)).await;
                                                    } else {
                                                        break;
                                                    }
                                                } else {
                                                    break;
                                                }
                                            } else {
                                                break;
                                            }
                                        },
                                        _ => {
                                            break;
                                        }
                                    }
                                } else {
                                    break;
                                }
                            }
                            rx = rx_events.recv().fuse() => {
                                match rx {
                                    Some(rx) => {
                                        if let Ok(x) = serde_json::to_string(&rx) {
                                            let _ = stream.send(tokio_tungstenite::tungstenite::Message::Text(x)).await;
                                        } else {
                                            break;
                                        }
                                    }
                                    None => {
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    if editor.bound {
                        let _ = context.editor_update_tx.send(EditorUpdate::Unbind).await;
                    }
                }
            });

            Ok(())
        }

        async fn process_request(
            req: Request<Body>,
            context: Context,
            rsp: &mut Response<Body>,
        ) -> Result<(), anyhow::Error> {
            Ok(match (req.method(), req.uri().path()) {
                (&hyper::Method::GET, WEBSOCKET_PATH) => {
                    handle_websocket_connection(&context, req, rsp)?;
                }
                _ => {}
            })
        }

        async fn service_handle(
            context: Context,
            req: Request<Body>,
        ) -> Result<Response<Body>, anyhow::Error> {
            let mut rsp = Response::new(Body::empty());
            *rsp.status_mut() = StatusCode::BAD_REQUEST;

            if let Err(_) = process_request(req, context, &mut rsp).await {
                *rsp.status_mut() = StatusCode::INTERNAL_SERVER_ERROR;
            }

            Ok(rsp)
        }

        let context = Context {
            dir: self.parsed_opts.parsing_cwd.to_string_lossy().as_ref().to_owned(),
            command: self.cmd.join(" "),
            editor_update_tx: self.editor_update_tx.clone(),
            shared: self.shared.clone(),
        };
        let uid = unsafe { libc::getuid() };
        let pid = unsafe { libc::getpid() };
        let socket_path = format!("/run/user/{uid}/eat/{pid}");
        let path = PathBuf::from(&socket_path);
        if let Some(parent) = path.parent() {
            let _ = std::fs::create_dir(parent);
        }

        let make_svc = make_service_fn(move |_conn| {
            let context = context.clone();
            let service_handler = move |req|
                service_handle(context.clone(), req);
            async move { Ok::<_, Infallible>(service_fn(service_handler)) }
        });

        let bound = hyper::Server::bind_unix(&socket_path)?;
        let server = bound.serve(make_svc);

        tokio::spawn(async move {
            server.await
        });

        Ok(())
    }

    async fn send_selected_match(&self) -> anyhow::Result<()> {
        if let Some(idx) = self.selected_match {
            if let Some(m) = self.found_matches.get(idx) {
                if let Some(controller_tx) = &self.controller_tx {
                    let _ = controller_tx.send(ControllerMessage::VisitSource {
                        pathname: self.parsed_opts.parsing_cwd.join(&m.file_name).to_string_lossy().as_ref().to_owned(),
                        line_idx: m.file_line as u32,
                    }).await;
                };
            }
        }

        Ok(())
    }
}

impl Context {
    async fn editor_message(&self, msg: EditorMessage, sender: &mpsc::Sender<ControllerMessage>, editor: &mut Editor) -> anyhow::Result<EatMessage> {
        match msg {
            EditorMessage::SendInfo => {
                return Ok(EatMessage::Info {
                    dir: self.dir.clone(),
                    command: self.command.clone(),
                    bound: self.shared.lock().await.bound,
                })
            },
            EditorMessage::Bind => {
                let (tx, mut rx) = tokio::sync::mpsc::channel(1);
                self.editor_update_tx.send(EditorUpdate::Bind(sender.clone(), tx)).await?;
                let _msg = rx.recv().await;
                editor.bound = true;
                return Ok(EatMessage::Ok);
            },
            EditorMessage::Next => {
                self.editor_update_tx.send(EditorUpdate::Next).await?;
                return Ok(EatMessage::Ok);
            },
            EditorMessage::Prev => {
                self.editor_update_tx.send(EditorUpdate::Prev).await?;
                return Ok(EatMessage::Ok);
            },
            EditorMessage::Redo => {
                self.editor_update_tx.send(EditorUpdate::Redo).await?;
                return Ok(EatMessage::Ok);
            },
            EditorMessage::First => {
                self.editor_update_tx.send(EditorUpdate::First).await?;
                return Ok(EatMessage::Ok);
            },
        }
    }
}

fn draw_line(buf: &mut ratatui::prelude::Buffer, rel_y: i16, bounds: Rect, undecoded_str: &str, selected: bool) -> u16 {
    let mut cs = Style::new().fg(Color::Rgb(255, 255, 255)).bg(Color::Rgb(0, 0, 0));
    let cs_reset = Style::new().fg(Color::Rgb(255, 255, 255)).bg(Color::Rgb(0, 0, 0)).reset();
    let orig_cs = if !selected { cs } else { cs.bg(Color::Rgb(80, 80, 80)) };
    let bad_ansi = Style::new().fg(Color::Rgb(255, 255, 255)).bg(Color::Rgb(255, 0, 0));
    let mut lines = 1;
    let mut y = (bounds.y as i16).saturating_add(rel_y);
    let mut x = bounds.x;
    let mut line_has_content = true;
    let start_of_line = (x, y);

    cs = cs_reset;

    let mut remove_cr: Vec<char> = undecoded_str.chars().collect();
    while let Some(last_r) =  remove_cr.iter().rposition(|x| *x == '\r') {
        if last_r + 1 == remove_cr.len() { // Ends with \r, let's find the second one
            remove_cr.truncate(last_r);
        } else { // There's text after '\r', let's just take it
            remove_cr = remove_cr.split_off(last_r + 1);
            break;
        }
    }

    for item in remove_cr.iter().collect::<String>().ansi_parse() {
        let mut unknown = None;
        match item {
            ansi_parser::Output::TextBlock(b) => {
                let v: Vec<char> = b.chars().collect();
                let mut v_scan  = 0;
                while v_scan < v.len() {
                    if y >= bounds.bottom() as i16 {
                        break;
                    }

                    let vec_remaining = v.len().saturating_sub(v_scan as usize);
                    let screen_remaining = bounds.right().saturating_sub(x) as usize;
                    let remaining = vec_remaining.min(screen_remaining);
                    if remaining == 0 {
                        y += 1;
                        x = bounds.x;
                        line_has_content = false;
                        continue;
                    }

                    let chunk = &v[v_scan..v_scan + remaining];
                    if !line_has_content {
                        lines += 1;
                        line_has_content = true;
                    }

                    if y >= bounds.y as i16 {
                        buf.set_string(x, y as u16, chunk.into_iter().collect::<String>(), cs);
                    }
                    x = x.saturating_add(chunk.len() as u16);
                    v_scan += remaining;
                }
            },
            ansi_parser::Output::Escape(e) => {
                match e {
                    AnsiSequence::SetGraphicsMode(v) => {
                        match v.as_slice() {
                            &[38, 2, r, g, b] => {
                                cs = cs.fg(Color::Rgb(r, g, b));
                            }
                            &[48, 2, r, g, b] => {
                                cs = cs.bg(Color::Rgb(r, g, b));
                            }
                            &[38, 5, r] => {
                                cs = cs.fg(Color::Indexed(r));
                            }
                            &[48, 5, r] => {
                                cs = cs.bg(Color::Indexed(r));
                            }
                            _ => {
                                for byte in v {
                                    match byte {
                                        0 => {
                                            cs = orig_cs;
                                        }
                                        30 => cs = cs.fg(Color::Black),
                                        31 => cs = cs.fg(Color::LightRed),
                                        32 => cs = cs.fg(Color::LightGreen),
                                        33 => cs = cs.fg(Color::LightYellow),
                                        34 => cs = cs.fg(Color::LightBlue),
                                        35 => cs = cs.fg(Color::LightMagenta),
                                        36 => cs = cs.fg(Color::LightCyan),
                                        37 => cs = cs.fg(Color::White),
                                        1 => cs = cs.add_modifier(Modifier::BOLD),
                                        3 => cs = cs.add_modifier(Modifier::ITALIC),
                                        4 => cs = cs.add_modifier(Modifier::UNDERLINED),
                                        7 => cs = cs.add_modifier(Modifier::REVERSED),
                                        9 => cs = cs.add_modifier(Modifier::CROSSED_OUT),
                                        e => {
                                            match unknown {
                                                Some(x) => {
                                                    unknown = Some(format!("<<{} - SGD[{:?}]>>", x, e))
                                                },
                                                None => {
                                                    unknown = Some(format!("<<SGD[{:?}]>>", e))
                                                },
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    AnsiSequence::EraseLine => {
                        x = start_of_line.0;
                        let empty = " ".repeat(bounds.width as usize);
                        for cy in start_of_line.1..=y {
                            if cy >= bounds.y as i16 {
                                buf.set_string(x, cy as u16, &empty, cs);
                            }
                        }
                        y = start_of_line.1;
                        line_has_content = true;
                        lines = 1;
                    }
                    e => {
                        unknown = Some(format!("<<ESC[{:?};>>", e));
                    }
                }
            }
        }

        if let Some(unknown) = unknown.take() {
            if y >= bounds.y as i16 {
                buf.set_string(x, y as u16, &unknown, bad_ansi);
            }
            x += unknown.len() as u16;
        }
    }

    let screen_remaining = bounds.right().saturating_sub(x) as usize;
    if screen_remaining > 0 {
        let empty = " ".repeat(screen_remaining as usize);
        if y >= bounds.y as i16 {
            buf.set_string(x, y as u16, &empty, cs);
        }
    }

    lines
}

enum Mode {
    Normal,
}

#[derive(Clone)]
enum Action {
    Exit,
    Redraw,
    NextMatch,
    PrevMatch,
    Redo,
    FirstMatch,
}

enum ProgramUpdate {
    Data(Vec<u8>),
    Abnormal(String),
    ExitStatus(ExitStatus),
}

#[derive(Copy, Clone, Eq, PartialEq, Debug)]
enum MatchKind {
    Error,
    Warning,
}

enum EditorUpdate {
    Bind(mpsc::Sender<ControllerMessage>, mpsc::Sender<()>),
    Unbind,
    Next,
    Prev,
    Redo,
    First,
}

struct Editor {
    bound: bool,
}

#[derive(Clone)]
struct Context {
    dir: String,
    command: String,
    editor_update_tx: mpsc::Sender<EditorUpdate>,
    shared: Arc<Mutex<Shared>>,
}

#[derive(Default)]
struct Shared {
    bound: bool,
}

#[derive(Serialize, Deserialize)]
enum EditorMessage {
    SendInfo,
    Bind,
    Next,
    Prev,
    Redo,
    First,
}

#[derive(Serialize)]
enum ControllerMessage {
    VisitSource {
        pathname: String,
        line_idx: u32,
    }
}

#[derive(Serialize, Deserialize)]
enum EatMessage {
    Info {
        dir: String,
        command: String,
        bound: bool,
    },
    Ok,
}

struct Main {
    mode: Mode,
    shared: Arc<Mutex<Shared>>,
    key_accum: EventVector,
    cmd: Vec<String>,
    exit: ExitStatus,
    running: bool,
    unexpected: String,
    program_update_rx: mpsc::Receiver<ProgramUpdate>,
    program_update_tx: mpsc::Sender<ProgramUpdate>,
    editor_update_rx: mpsc::Receiver<EditorUpdate>,
    editor_update_tx: mpsc::Sender<EditorUpdate>,
    controller_tx: Option<mpsc::Sender<ControllerMessage>>,
    raw_output: String,
    output_line_scan: usize,
    output_regex_scan: usize,
    line_offsets: Vec<usize>,
    no_color_output: String,
    no_color_output_scan: usize,
    no_color_lines: usize,
    no_color_line_offset_to_idx: BTreeMap<usize, usize>,
    found_matches: Vec<Match>,
    matchers: Vec<(MatchKind, Regex)>,
    selected_match: Option<usize>,
    parsed_opts: ParsedOpts,
}

#[derive(Debug)]
struct Match {
    match_kind: MatchKind,
    start_line_idx: usize,
    end_line_idx: usize,
    file_name: String,
    file_line: u64,
}

impl Main {
    fn new(parsed_opts: ParsedOpts, v: Vec<String>) -> anyhow::Result<Self> {
        let (program_update_tx, program_update_rx) = mpsc::channel(100);
        let (editor_update_tx, editor_update_rx) = mpsc::channel(10);

        Ok(Self {
            exit: Default::default(),
            mode: Mode::Normal,
            cmd: v,
            parsed_opts,
            key_accum: EventVector::new(),
            program_update_rx,
            program_update_tx,
            editor_update_rx,
            editor_update_tx,
            raw_output: Default::default(),
            line_offsets: vec![0],
            output_line_scan: Default::default(),
            no_color_output: Default::default(),
            no_color_output_scan: 0,
            no_color_line_offset_to_idx: vec![(0, 0)].into_iter().collect(),
            no_color_lines: 1,
            running: false,
            unexpected: "".to_owned(),
            matchers: vec![
                (MatchKind::Error,
                 Regex::new(r#"(?m)^error(\[.*\])?:.*\n.*-->.* (?P<filename>[^:]+):(?P<line>[0-9]+)(:[0-9]+)?\n"#)?
                 ),
                (MatchKind::Warning,
                 Regex::new(r#"(?m)(^warning\[|^warning:).*\n.*-->.* (?P<filename>[^:]+):(?P<line>[0-9]+)(:[0-9]+)?\n"#)?
                 ),
            ],
            output_regex_scan: 0,
            found_matches: vec![],
            controller_tx: None,
            shared: Arc::new(Mutex::new(Default::default())),
            selected_match: None,
        })
    }
}

async fn eat_async(po: ParsedOpts, eat_mode: &[String]) -> anyhow::Result<()> {
    let mut main = Main::new(po, eat_mode.iter().map(|x| (*x).to_owned()).collect())?;
    main.run().await?;
    let status = main.exit;

    std::process::exit(
        status
            .code()
            .unwrap_or_else(|| status.signal().unwrap_or(0) + 128),
    );
}

fn eat(po: ParsedOpts, eat_mode: &[String]) -> anyhow::Result<()> {
    tokio::runtime::Builder::new_current_thread().enable_all().build()?.block_on(async move {
        eat_async(po, eat_mode).await
    })?;

    Ok(())
}

#[derive(Debug, StructOpt)]
pub struct Opts {
    #[structopt(long, short = "e")]
    pub exec_cwd: Option<PathBuf>,

    #[structopt(long, short = "c")]
    pub parsing_cwd: Option<PathBuf>,

    #[structopt(flatten)]
    pub cmd: Sub,
}

#[derive(Debug, StructOpt)]
pub enum Sub {
    #[structopt(external_subcommand)]
    Eat(Vec<String>),
}

fn with_cwd(p: &Option<PathBuf>) -> PathBuf {
    let cwd = match std::env::current_dir() {
        Ok(cwd) => cwd,
        Err(e) => {
            eprintln!("error getting current directory: {:?}", e);
            std::process::exit(255);
        },
    };

    match p {
        Some(p) =>  cwd.join(PathBuf::from(p)),
        None => cwd,
    }
}

struct ParsedOpts {
    exec_cwd: PathBuf,
    parsing_cwd: PathBuf,
}

fn main() {
    let opts = Opts::from_args();
    let exec_cwd = with_cwd(&opts.exec_cwd);
    let parsing_cwd = with_cwd(&opts.parsing_cwd);
    let po = ParsedOpts { exec_cwd, parsing_cwd };
    let err = eat(po, match &opts.cmd {
        Sub::Eat(items) => &items,
    });

    match err {
        Ok(_) => {
            std::process::exit(0);
        },
        Err(e) => {
            eprintln!("error: {:?}", e);
            std::process::exit(255);
        },
    }
}
