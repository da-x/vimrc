#![allow(unused)]
//! Types to manage mapping of key combinations to actions

use ratatui::crossterm::event::{KeyCode, KeyEvent, KeyModifiers};
use std::collections::HashMap;

#[derive(Debug, Hash, Copy, Clone, Default, Eq, PartialEq)]
pub struct Modifiers {
    ctrl: bool,
    alt: bool,
    shift: bool,
}

impl Modifiers {
    fn shift(self) -> Self {
        Self {
            shift: true,
            ..self
        }
    }

    fn ctrl(self) -> Self {
        Self { ctrl: true, ..self }
    }
}

#[derive(Eq, Hash, PartialEq, Debug, Clone)]
pub enum KeyCombination {
    Specific(KeyCode, Modifiers),
    AllChars(Modifiers),
}

use std::fmt;

impl fmt::Display for KeyCombination {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            KeyCombination::Specific(key_code, modifiers) => {
                if modifiers.ctrl {
                    write!(f, "C-")?;
                }
                if modifiers.alt {
                    write!(f, "M-")?;
                }
                if modifiers.shift {
                    write!(f, "Shift-")?;
                }
                let s = match key_code {
                    KeyCode::Backspace => "Backspace".to_owned(),
                    KeyCode::Enter => "Enter".to_owned(),
                    KeyCode::Left => "Left".to_owned(),
                    KeyCode::Right => "Right".to_owned(),
                    KeyCode::Up => "Up".to_owned(),
                    KeyCode::Down => "Down".to_owned(),
                    KeyCode::Home => "Home".to_owned(),
                    KeyCode::End => "End".to_owned(),
                    KeyCode::PageUp => "PageUp".to_owned(),
                    KeyCode::PageDown => "PageDown".to_owned(),
                    KeyCode::Tab => "Tab".to_owned(),
                    KeyCode::BackTab => "BackTab".to_owned(),
                    KeyCode::Delete => "Delete".to_owned(),
                    KeyCode::Insert => "Insert".to_owned(),
                    KeyCode::F(i) => format!("F{}", i),
                    KeyCode::Char(' ') => format!("Space"),
                    KeyCode::Char('*') => format!("'*'"),
                    KeyCode::Char(',') => format!("','"),
                    KeyCode::Char(ch) => format!("{}", ch),
                    KeyCode::Null => format!("<null>"),
                    KeyCode::Esc => format!("Esc"),
                    KeyCode::CapsLock => format!("CapsLock"),
                    KeyCode::ScrollLock => format!("ScrollLock"),
                    KeyCode::NumLock => format!("NumLock"),
                    KeyCode::PrintScreen => format!("PrintScreen"),
                    KeyCode::Pause => format!("Pause"),
                    KeyCode::Menu => format!("Menu"),
                    KeyCode::KeypadBegin => format!("KeypadBegin"),
                    KeyCode::Media(_) => format!("Media<?>"),
                    KeyCode::Modifier(_) => format!("Modifier<?>"),
                };
                write!(f, "{}", s)
            }
            _ => write!(f, "?"),
        }
    }
}

pub struct KeyMap<A> {
    map: HashMap<KeyCombination, A>,
}

impl<A> Default for KeyMap<A> {
    fn default() -> Self {
        KeyMap::new()
    }
}

impl<A> KeyMap<A> {
    pub fn new() -> Self {
        Self {
            map: Default::default(),
        }
    }

    #[allow(unused)]
    pub fn map(&self) -> &HashMap<KeyCombination, A> {
        &self.map
    }

    pub fn add_no_mods(&mut self, code: KeyCode, a: A) {
        self.map
            .insert(KeyCombination::Specific(code, Modifiers::default()), a);
    }

    pub fn add_ctrl(&mut self, code: KeyCode, a: A) {
        self.map.insert(
            KeyCombination::Specific(code, Modifiers::default().ctrl()),
            a,
        );
    }

    pub fn add_shift(&mut self, code: KeyCode, a: A) {
        let code = match code {
            KeyCode::Char(c) => KeyCode::Char(c.to_uppercase().to_string().chars().nth(0).unwrap()),
            x => x,
        };
        self.map.insert(
            KeyCombination::Specific(code, Modifiers::default().shift()),
            a,
        );
    }

    #[allow(unused)]
    pub fn add_char_no_handler(&mut self, a: A) {
        self.map
            .insert(KeyCombination::AllChars(Modifiers::default()), a);
    }

    #[allow(unused)]
    pub fn add_char_shift(&mut self, a: A) {
        self.map
            .insert(KeyCombination::AllChars(Modifiers::default().shift()), a);
    }

    pub fn get_action(&self, key_event: KeyEvent) -> Option<&A> {
        let modifiers = key_event.modifiers;
        let modifiers = Modifiers {
            ctrl: modifiers.contains(KeyModifiers::CONTROL),
            shift: modifiers.contains(KeyModifiers::SHIFT),
            alt: modifiers.contains(KeyModifiers::ALT),
        };
        if let Some(action) = self
            .map
            .get(&KeyCombination::Specific(key_event.code, modifiers))
        {
            return Some(action);
        }
        if let KeyCode::Char(_) = key_event.code {
            if let Some(action) = self.map.get(&KeyCombination::AllChars(modifiers)) {
                return Some(action);
            }
        }
        None
    }
}

pub enum TreeNode<A> {
    #[allow(unused)] // TODO
    Tree(KeyTree<A>),
    Action(A),
}

impl<A> Default for TreeNode<A>
where
    A: Default,
{
    fn default() -> Self {
        TreeNode::Action(Default::default())
    }
}

#[derive(Default)]
pub struct KeyTree<A> {
    map: KeyMap<TreeNode<A>>,
}

impl<A> KeyTree<A> {
    pub fn new() -> Self {
        Self { map: KeyMap::new() }
    }

    pub fn map(&self) -> &KeyMap<TreeNode<A>> {
        &self.map
    }

    #[allow(unused)]
    pub fn add_vector(&mut self, _code: Vec<KeyCombination>, _a: A) {
        todo!();
    }

    pub fn get_mappings(&self) -> Vec<(Vec<KeyCombination>, &A)> {
        fn get_mappings<A>(tree: &KeyMap<TreeNode<A>>) -> Vec<(Vec<KeyCombination>, &A)> {
            let mut v = vec![];

            // let bt: BTreeMap<_, _> = tree.map.iter().collect();
            for (key, value) in tree.map.iter() {
                match value {
                    TreeNode::Tree(key_tree) => {
                        for (mut sub, a) in get_mappings(key_tree.map()).into_iter() {
                            sub.insert(0, key.clone());
                            v.push((sub, a));
                        }
                    },
                    TreeNode::Action(a) => {
                        v.push((vec![key.clone()], a));
                    },
                }
            }

            v
        }

        get_mappings(&self.map)
    }

    pub fn add_no_mods(&mut self, code: KeyCode, a: A) {
        self.map.add_no_mods(code, TreeNode::Action(a))
    }

    pub fn add_ctrl(&mut self, code: KeyCode, a: A) {
        self.map.add_ctrl(code, TreeNode::Action(a))
    }

    pub fn add_shift(&mut self, code: KeyCode, a: A) {
        self.map.add_shift(code, TreeNode::Action(a))
    }

    #[allow(unused)]
    pub fn add_char_no_handler(&mut self, a: A) {
        self.map.add_char_no_handler(TreeNode::Action(a))
    }

    #[allow(unused)]
    pub fn add_char_shift(&mut self, a: A) {
        self.map.add_char_shift(TreeNode::Action(a))
    }
}

pub struct EventVector {
    key_accum: Vec<ratatui::crossterm::event::KeyEvent>,
}

pub struct ActiveEventVector<'a, 'b, A> {
    ev: &'a mut EventVector,
    keymap: &'b KeyTree<A>,
}

impl EventVector {
    pub fn new() -> Self {
        Self {
            key_accum: vec![]
        }
    }

    pub fn accum_get<'a, 'b, A>(&'a mut self, keymap: &'b KeyTree<A>) -> ActiveEventVector<'a, 'b, A> {
        ActiveEventVector {
            ev: self,
            keymap,
        }
    }
}

impl<'a, 'b, A> ActiveEventVector<'a, 'b, A> {
    pub fn get_action(&mut self, key: KeyEvent) -> Option<&A> {
        let mut map = self.keymap.map();

        loop {
            if let Some(x) = map.get_action(key) {
                match x {
                    TreeNode::Tree(key_tree) => {
                        self.ev.key_accum.push(key);
                        map = key_tree.map();
                    },
                    TreeNode::Action(action) => {
                        self.ev.key_accum.clear();
                        return Some(action);
                    },
                }
            } else {
                self.ev.key_accum.clear();
                return None;
            }
        }
    }
}
