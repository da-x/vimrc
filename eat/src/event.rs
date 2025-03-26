#![allow(unused)]
use std::time::Duration;

use crossterm::event::{Event as CrosstermEvent, KeyEvent, MouseEvent};
use futures::{FutureExt, StreamExt};
use tokio::sync::mpsc;

#[derive(Clone, Debug)]
pub enum ProgramEvent {
    Tick,
    Crossterm(crossterm::event::Event),
}

#[derive(Debug)]
pub struct EventHandler {
    sender: mpsc::UnboundedSender<ProgramEvent>,
    receiver: mpsc::UnboundedReceiver<ProgramEvent>,
    handler: tokio::task::JoinHandle<()>,
}

impl EventHandler {
    pub fn new(tick_rate: u64) -> Self {
        let tick_rate = Duration::from_millis(tick_rate);
        let (sender, receiver) = mpsc::unbounded_channel();
        let _sender = sender.clone();

        let handler = tokio::spawn(async move {
            let mut reader = crossterm::event::EventStream::new();
            let mut tick = tokio::time::interval(tick_rate);

            loop {
                let tick_delay = tick.tick();
                let crossterm_event = reader.next().fuse();
                tokio::select! {
                    _ = _sender.closed() => {
                        break;
                    }
                    _ = tick_delay => {
                        _sender.send(ProgramEvent::Tick).unwrap();
                    }
                    Some(Ok(evt)) = crossterm_event => {
                        _sender.send(ProgramEvent::Crossterm(evt)).unwrap();
                    }
                };
            }
        });

        Self {
            sender,
            receiver,
            handler,
        }
    }

    /// Receive the next event from the handler thread.
    ///
    /// This function will always block the current thread if
    /// there is no data available and it's possible for more data to be sent.
    pub async fn next(&mut self) -> anyhow::Result<ProgramEvent> {
        self.receiver
            .recv()
            .await
            .ok_or_else(|| anyhow::anyhow!("no event"))
    }
}
