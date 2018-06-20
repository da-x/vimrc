" =============================================================================
" Welcome!

" Some original work, plus some bits from: https://github.com/amix/vimrc
" Others from https://github.com/jonhoo/configs/blob/master/.vimrc

" =============================================================================
" # PLUGINS
" =============================================================================

call plug#begin('~/.vim_runtime/vim-plugged')

" Libs
Plug 'LucHermitte/lh-vim-lib'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'vim-scripts/tlib'
Plug 'roxma/vim-hug-neovim-rpc'

" Settings
Plug 'LucHermitte/local_vimrc'
Plug 'airblade/vim-rooter'

" Navigation and other state manipulation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'

" Text manipulation
Plug 'AndrewRadev/sideways.vim'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/auto-pairs-gentle'

" Snipppets
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'da-x/gv.vim'
Plug 'tpope/vim-fugitive'

" Visual effects
Plug 'machakann/vim-highlightedyank'

" Themes
Plug 'itchyny/lightline.vim'
Plug 'da-x/ale'

" Search
Plug 'mhinz/vim-grepper'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" RPC and completions
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-yarp'

if has('nvim')
  Plug 'roxma/nvim-completion-manager'
endif

" Syntax related
Plug 'da-x/vim-markdown'
Plug 'vivien/vim-linux-coding-style'
Plug 'rust-lang/rust.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'cespare/vim-toml'
Plug 'vimoutliner/vimoutliner'

" Language related
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

" Other
Plug 'junegunn/vader.vim'
Plug 'Shougo/echodoc.vim'

call plug#end()

" =============================================================================
" Terminal fixups

" Various missing ansi code mappings, plus special mappings that are intrinsic
" to how I configure Alacritty.

map <Char-0x0c> :call OnF11()<CR>
map <Char-0x1c> :call OnCtrlBar()<CR>
map <Char-0x1f> :call OnCtrlMinus()<CR>

map <ESC><Char-0x10> <C-A-p>
map <ESC>[11;3~ <A-F1>
map <ESC>[11;5~ <C-F1>
map <ESC>[11;6~ <C-S-F1>
map <ESC>[12;3~ <A-F2>
map <ESC>[12;5~ <C-F2>
map <ESC>[12;6~ <C-S-F2>
map <ESC>[13;3~ <A-F3>
map <ESC>[13;5~ <C-F3>
map <ESC>[13;6~ <C-S-F3>
map <ESC>[14;3~ <A-F4>
map <ESC>[14;5~ <C-F4>
map <ESC>[14;6~ <C-S-F4>
map <ESC>[1;5P <C-F1>
map <ESC>[1;5Q <C-F2>
map <ESC>[1;5R <C-F3>
map <ESC>[1;5S <C-F4>
map <ESC>[3;5~ <C-Delete>
map <ESC>[5;30001~ <S-CR>
map <ESC>[5;30002~ <A-CR>
map <ESC>[5;30003~ <C-CR>
map <ESC>[5;30004~ <C-S-s>
map <ESC>[5;30005~ <C-A-CR>
map <ESC>[5;30014~ <C-Space>
map <ESC>[Z <S-tab>
map <ESC>a <A-a>
map <ESC>h <A-h>
map <ESC>r <A-r>
map <ESC>w <A-w>
map <ESC>j <M-j>
map <ESC>k <M-k>
map <ESC>p <A-p>
map <ESC>t <A-t>
map <ESC>1 <A-1>
map <ESC>2 <A-2>
map <ESC>3 <A-3>
map <ESC>4 <A-4>
map <ESC>q <A-q>
map <ESC>y <A-y>
map <ESC>e <A-e>
map <ESC>d <A-d>
map <ESC>[4~ <End>
map! <ESC><Char-0x10> <C-A-p>
map! <ESC>[11;3~ <A-F1>
map! <ESC>[11;5~ <C-F1>
map! <ESC>[11;6~ <C-S-F1>
map! <ESC>[12;3~ <A-F2>
map! <ESC>[12;5~ <C-F2>
map! <ESC>[12;6~ <C-S-F2>
map! <ESC>[13;3~ <A-F3>
map! <ESC>[13;5~ <C-F3>
map! <ESC>[13;6~ <C-S-F3>
map! <ESC>[14;3~ <A-F4>
map! <ESC>[14;5~ <C-F4>
map! <ESC>[14;6~ <C-S-F4>
map! <ESC>[1;5P <C-F1>
map! <ESC>[1;5Q <C-F2>
map! <ESC>[1;5R <C-F3>
map! <ESC>[1;5S <C-F4>
map! <ESC>[3;5~ <C-Delete>
map! <ESC>[5;30001~ <S-CR>
map! <ESC>[5;30002~ <A-CR>
map! <ESC>[5;30003~ <C-CR>
map! <ESC>[5;30004~ <C-S-s>
map! <ESC>[5;30005~ <C-A-CR>
map! <ESC>[5;30014~ <C-Space>
map! <ESC>j <M-j>
map! <ESC>k <M-k>
map! <ESC>p <A-p>
map! <ESC>t <A-t>
map! <ESC>1 <A-1>
map! <ESC>2 <A-2>
map! <ESC>3 <A-3>
map! <ESC>4 <A-4>
map! <ESC>q <A-q>
map! <ESC>e <A-e>
map! <ESC>d <A-d>
map! <ESC>[4~ <End>

" Make keystores the most predictable being time-independent:
set notimeout
set nottimeout

" To be most compatible in a subprocess invocations
set shell=/bin/bash

" Prevent Ctrl-S terminal suspend function
silent exec "!stty -ixon"

if !has('nvim')
  set term=xterm-256color
endif

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Fast terminal
set showcmd
set lazyredraw

" Give indication in which mode we are at, using a cursor shape.
" | for insert
" _ for replace
" ■ for normal
augroup CursorShape
  " This is in an BufEnter autocmds because for some reason vim-gnupg reverts
  " to the original behavior.
  autocmd!

  autocmd BufEnter * call LoadCursorShapes()
augroup END

function! LoadCursorShapes()
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endfunction

call LoadCursorShapes()

" =============================================================================
" Main settings
"
" Leader key
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
map <Space> <leader>

" Wild menu
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
set wildmenu

" Tabs and indentation
set autoindent
set cindent
set cinoptions=:0,l1,t0,g0,(0
set smartcase
set shiftwidth=4
set smarttab
set softtabstop=8
set noexpandtab

" Backup files and undo
set nobackup
set undodir=~/.vim_runtime/.temp_dirs/undodir
set undofile
set noswapfile
set nowritebackup

" Appearance of stuff
set number
set ruler
set cmdheight=2
set completeopt-=preview
set showmatch
set matchtime=2
set showtabline=2
set laststatus=2
set foldcolumn=1
set noshowmode
set shortmess+=atc
set scrolloff=3

" Misc
set history=500
set magic
set noequalalways
set nofoldenable
set noignorecase
set switchbuf=useopen
set matchpairs+=<:>

" Windowing
set hidden
set splitbelow
set splitright

" Encoding and file formats
set encoding=utf8
set fileformats=unix,dos,mac

" Bells
set noerrorbells
set novisualbell
set t_vb=

" Possible tag files
set tags=._TAGS_,./rusty-tags.vi;/

" =============================================================================
" Disabling various behaviors using mappings

" Disable ex mode, I keep entering it by mistake
map q: <Nop>

" =============================================================================
" Various single-line shortcuts

" Fast saving
nnoremap <leader>w :w!<CR>

" Quickly record a macro and execute it
nnoremap <F6> qm
nnoremap <C-F6> @m
imap <F6> <C-c><F6>
imap <C-F6> <C-c><C-F6>

" No need for entering shift when going into command mode
nnoremap ; :

" Quickly switch to other buffer
nnoremap <leader><leader> <c-^>

" Disable highlight when <leader><CR> is pressed
map <silent> <leader><CR> :noh<CR>

" =============================================================================
" Various mappings for function keys

nmap <F2> :Buffers<CR>
map! <F2> <Nop>
imap <F2> <C-c><F2>
nmap <C-F2> :CtrlPMRUFiles<CR>
map! <C-F2> <Nop>
imap <C-F2> <C-c><C-F2>
nmap <F3> :NERDTreeFind<CR>
map! <F3> <Nop>
imap <F3> <C-c><F3>
nmap <C-F3> :NERDTreeToggle<CR>
map! <C-F3> <Nop>
imap <C-F3> <C-c><F3>
nmap <C-S-F3> :CtrlP<CR>
map! <C-S-F3> <Nop>
imap <C-S-F3> <C-c><F3>

" Navigate location lists
nmap <F4> :lnext<CR>
map! <F4> <Nop>
imap <F4> <C-c><F4>
nmap <M-F4> :lprev<CR>
map! <M-F4> <Nop>
imap <M-F4> <C-c><M-F4>
nmap <C-S-F4> :lfirst<CR>
map! <C-S-F4> <Nop>
imap <C-S-F4> <C-c><C-F4>
nmap <C-F4> :lopen<CR>
map! <C-F4> <Nop>
imap <C-F4> <C-c><C-F4>

" Navigate the quickfix list
nmap <F5> :cnext<CR>
map! <F5> <Nop>
imap <F5> <C-c><F5>
nmap <M-F5> :cprev<CR>
map! <M-F5> <Nop>
imap <M-F5> <C-c><M-F5>
nmap <C-F5> :cfirst<CR>
map! <C-F5> <Nop>
imap <C-F5> <C-c><C-F5>

" =============================================================================
" Auto-read
"
" Set to auto read when a file is changed from the outside
set autoread

augroup CursorHoldCheckTime
  autocmd!
  autocmd CursorHold * checktime
augroup END

" =============================================================================
" Maps for Editing

" Split lines at cursor quickly using C-k
nnoremap <C-k> i<CR><Esc>

" Make Backspace behave like it normally does, in normal mode
nnoremap <BS> "_X

" Function and hotkey to duplicate a line for the purpose of editing the
" duplicate. Seems to be doing that a lot.
function! DuplicateLine() abort
  " And keep in the same column
  let l:prevpos = getcurpos()
  execute "t."
  let l:curpos = getcurpos()
  let l:curpos_prev_col = [l:curpos[0], l:curpos[1], l:prevpos[2], l:curpos[3]]
  call setpos(".", l:curpos_prev_col)
endfunction

nnoremap <leader>d :call DuplicateLine()<CR>

" Remap Ctrl-D to a single line removal, not affecting the register
nnoremap <C-d> "_dd

" Use the delete key without affecting the register
nnoremap <Delete> "_x

" 'u' and 'U' should not change case in visual mode as 'u' already
" does entirely different thing in normal mode. Make them consistent,
" and rebind these actions to be under the leader prefix. They are
" rare enough as it is.
vnoremap <leader>u u
vnoremap <leader>U U
vnoremap u <C-c>u
vnoremap U <C-c>U

" Moving text up and down, either the current line or a selection, adjusting
" for indentation. Extremely handy when re-ordering code manually.
nnoremap <M-j> :m .+1<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-k> :m '<-2<CR>gv=gv

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<CR>

" Limit idle time in insert mode
augroup PreventInsertModeStalling
  autocmd!
  autocmd CursorHoldI * stopinsert
  autocmd InsertEnter * let updaterestore=&updatetime | set updatetime=60000
  autocmd InsertLeave * let &updatetime=updaterestore
augroup END

" Search replace the highlight marking, either in the entire buffer or in the
" currently selected region in visual mode.
nnoremap <A-h> :%s///g<left><left>
vnoremap <A-h> :s///g<left><left>

function! InsertSelectionText() abort
  let l:search_mark = @/
  let l:n = strlen(l:search_mark)
  echom strpart(l:search_mark, 0, 1)
  echom strpart(l:search_mark, l:n - 1, 1)
  if strpart(l:search_mark, 0, 2) ==# "\\<" && strpart(l:search_mark, l:n - 2, 2) ==# "\\>"
    let l:search_mark = strpart(l:search_mark, 2, l:n - 4)
  endif
  return l:search_mark
endfunction

" Search and replace the current word at cursor, either with an edit or with
" a new expression.
nnoremap <A-r> :%s//<C-r>=InsertSelectionText()<CR>/g<left><left>
vnoremap <A-r> :s//<C-r>=InsertSelectionText()<CR>/g<left><left>
nnoremap <A-w> :%s/<C-r><C-w>/<C-r><C-w>/g<left><left>
vnoremap <A-w> :s/<C-r><C-w>/<C-r><C-w>/g<left><left>

" Add a newline and move down
noremap <silent> <C-J> O<Esc>j

" Operator pending remaps ( http://learnvimscriptthehardway.stevelosh.com/chapters/15.html )
onoremap ( i(
onoremap ' i'
onoremap " i"
onoremap < i<
onoremap [ i[
onoremap { i{
onoremap p( :<c-u>normal! F(vi(<CR>
onoremap p' :<c-u>normal! F'vi'<CR>
onoremap p" :<c-u>normal! F"vi"<CR>
onoremap p< :<c-u>normal! F<vi<<CR>
onoremap p[ :<c-u>normal! F[vi<<CR>
onoremap p{ :<c-u>normal! F{vi{<CR>
onoremap n( :<c-u>normal! f(vi(<CR>
onoremap n' :<c-u>normal! f'vi'<CR>
onoremap n" :<c-u>normal! f"vi"<CR>
onoremap n< :<c-u>normal! f<vi<<CR>
onoremap n[ :<c-u>normal! f[vi<<CR>
onoremap n{ :<c-u>normal! f{vi{<CR>

" Single character insertion
noremap <silent> <A-a> "=nr2char(getchar())<CR>P

" Shift-Enter in insert mode is just Enter
imap <S-CR> <CR>

" Change until a certain character
noremap <leader>_ ct_
noremap <leader>- ct-
noremap <leader>' ct'
noremap <leader>" ct"
noremap <leader>, ct,
noremap <leader>; ct;

" Delete stuff backwards happens too often
nnoremap cH xcT<Space>
nnoremap dH xdF<Space>

" Removes trailing spaces
function! TrimWhiteSpace() abort
  %s/\s\+$//e
endfunction

" =============================================================================
" MoveTo
"
" Hack for moving text from where you are to some place else where is a mark,
" and staying where you are.
"
" Move either the current line or the selected text to the place where
" there's a marker, moving keeping the marker down after the new place
" of the text, while keeping the cursor where the text was. This works
" whether the marker is global or local, so it can be used between
" buffers freely.
"
" The function is useful when moving scattered pieces of text from one
" file to another (imagine splitting a C header file, for example).
"
command! -range -nargs=* MoveTo :<line1>,<line2>call MoveTextToMarkAndStay(<f-args>)

function! MoveTextToMarkAndStay(marker) abort range
  let l:markx = getpos("'".a:marker)
  if l:markx[1] ==# 0
    echo "No marker set"
    return
  endif
  let l:curx = getcurpos()
  let l:cur = [bufnr("%"), l:curx[1], l:curx[2], l:curx[3], l:curx[4]]
  if l:markx[0] ==# 0
    let l:mark = [bufnr("%"), l:markx[1], l:markx[2], l:markx[3]]
  else
    let l:mark = l:markx
  endif
  if l:mark[0] ==# l:cur[0]
    " Same buffer
    let l:line = l:cur[1]
    let l:col = l:cur[2]
    let l:mark_line = line("'".a:marker)
    if a:lastline != a:firstline
      execute "'<,'>move '".a:marker."-1"
    else
      execute "move '".a:marker."-1"
    endif
  else
    " Different buffer
    let l:mark = [l:markx[0], l:markx[1] - 1, l:markx[2], l:markx[3]]
    if a:lastline != a:firstline
      execute "'<,'>delete"
    else
      execute "delete"
    endif
    execute "buffer " . l:mark[0]
    call setpos(".", l:mark)
    execute "put"
    execute "buffer " . l:cur[0]
  endif
  call setpos(".", l:cur)
endfunction

" =============================================================================
" Settings and maps for movement

set linebreak
set whichwrap+=<,>
set wrap
set nostartofline
set backspace=eol,start,indent

" Faster moving of the cursor using Ctrl and arrows
nnoremap <silent> <C-Up>   {
nnoremap <silent> <C-Down> }
inoremap <silent> <C-Up>   <C-c>{i
inoremap <silent> <C-Down> <C-c>}i
vnoremap <silent> <C-Up>   {
vnoremap <silent> <C-Down> }

" Got used to this from other environments (go to start of file / end of file)
nnoremap <silent> <C-Home> 1G
nnoremap <silent> <C-End>  G

" When navigating on line wraps with arrows, be more visual about it
nnoremap <Down> gj
nnoremap <Up>   gk

" Arrows are special and break out of operator-pending mode. Can still use
" hjkl in operator mode.
omap <Down>  <Esc><Down>
omap <Up>    <Esc><Up>
omap <Right> <Esc><Right>
omap <Left>  <Esc><Left>

" Allow cursor to go after one last character of the line, like in
" modern editing environments.
set virtualedit=onemore,block

" Make <End> really go to the end of line (but only in normal mode),
" because in visual mode we already have it.
nnoremap <expr> <End> (col('$') > 1 ? "<end><right>":'')

" Remap 0 to first non-blank character
noremap 0 ^

" Modern-like selections (moving with shift)
nnoremap <S-Up> v<Up>
nnoremap <S-Down> v<Down>
nnoremap <S-Left> v<Left>
nnoremap <S-Right> v<Right>
nnoremap <S-Home> v<Home>
nnoremap <S-End> v<End>
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>
vnoremap <S-End> <End>
vnoremap <S-Home> <Home>

" Exit insert mode (other than <Esc> and <C-c>)
inoremap jK x<C-c>"_x

" Exit insert and keep in the same place (because of virtualedit=onemore)
inoremap <silent> <C-Delete> <C-O>:stopinsert<CR>
map <C-Delete> <Nop>

" Save time by using C-^ from insert mode
imap <C-^> <C-c><C-^>

" =============================================================================
" Searching

set hlsearch
set incsearch

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy/<C-R><C-R>=substitute(
      \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy?<C-R><C-R>=substitute(
      \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>

" Select the current cursor word and search it in the buffer, without
" moving, unlike '*' and '#' which move. If there is a selection, it is
" used instead.
vmap <A-t> *``
imap <A-t> <C-c>*``
nmap <A-t> *``

" Be similar to other programs:
map <C-f> /

" =============================================================================
" Shortcuts for quickly opening various config files

nnoremap <leader>ea :e! ~/.config/alacritty/alacritty.yml<CR>
nnoremap <leader>ee :e! ~/.vim_runtime/vimrc.vim<CR>
nnoremap <leader>eg :e! ~/.files/gitconfig<CR>
nnoremap <leader>et :e! ~/.tmux.conf<CR>
nnoremap <leader>ex :e! ~/.Xdefaults<CR>
nnoremap <leader>ez :e! ~/.zsh/zshrc.sh<CR>
nnoremap <leader>e_ :e! ~/.vim_runtime/project-specific.vim<CR>
nnoremap <leader>ed :e! .git/todo.md<CR>

" =============================================================================
" Behaviors to have when opening buffers

" Return to last edit position when opening files (You want this!)
augroup BasicLastEdit
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" Mark '.orig' file buffers as read-only on open
augroup MarkOrigReadonly
  autocmd!
  autocmd BufRead *.orig setlocal readonly
augroup END

" =============================================================================
" Window management

" Tab is nicer than <C-w>
nnoremap <tab> <C-w>
nnoremap <tab><tab> <C-w><C-w>
nnoremap <tab>\ <C-w>v
nnoremap <tab>- <C-w>s

" Resizing windows - thanks https://github.com/assaflavie
nnoremap <silent> -        :resize -2<CR>
nnoremap <silent> =        :resize +2<CR>
nnoremap <silent> <Bar>    :vert resize +2<CR>
nnoremap <silent> <Bslash> :vert resize -2<CR>

" Splitting windows
function! OnCtrlBar() abort
  exec "vsplit"
endfunction

function! OnCtrlMinus() abort
  exec "split"
endfunction

" =============================================================================
" Tab management (I am not really using tabs, but this is handy)

noremap <C-t><Insert> :tabnew<CR>
noremap! <C-t><Insert> <C-c><C-t><Insert>
noremap <C-t><Delete> :tabclose<CR>
noremap! <C-t><Delete> <C-c><C-t><Delete>
noremap <C-t><Left> :-tabmove<CR>
noremap! <C-t><Left> <C-c><C-t><Left>
noremap <C-t><Right> :+tabmove<CR>
noremap! <C-t><Right> <C-c><C-t><Right>
noremap <C-t><Home> :0tabmove<CR>
noremap! <C-t><Home> <C-c><C-t><Home>
noremap <C-t><End> :tabmove<CR>
noremap! <C-t><End> <C-c><C-t><End>
noremap <C-t>1 :1tabnext<CR>
noremap <C-t>2 :2tabnext<CR>
noremap <C-t>3 :3tabnext<CR>
noremap <C-t>4 :4tabnext<CR>
noremap <C-t>5 :5tabnext<CR>
noremap <C-t>6 :6tabnext<CR>
noremap <C-t>7 :7tabnext<CR>
noremap <C-t>8 :8tabnext<CR>
noremap <C-t>9 :9tabnext<CR>
noremap! <C-t>1 :1tabnext<CR>
noremap! <C-t>2 :2tabnext<CR>
noremap! <C-t>3 :3tabnext<CR>
noremap! <C-t>4 :4tabnext<CR>
noremap! <C-t>5 :5tabnext<CR>
noremap! <C-t>6 :6tabnext<CR>
noremap! <C-t>7 :7tabnext<CR>
noremap! <C-t>8 :8tabnext<CR>
noremap! <C-t>9 :9tabnext<CR>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
nmap <C-t><Cr> <leader>tl

augroup BasicTabLeave
  autocmd!
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

map <leader>te :tabedit <c-r>=expand("%:p:h")<CR>/
map <leader>cd :cd %:p:h<CR>:pwd<CR>

" =============================================================================
" Spell checking

" Pressing ,ss will toggle and untoggle spell checking
nnoremap <leader>ss :setlocal spell!<CR>

" Shortcuts using <leader>
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=

" =============================================================================
" DiffView
"
" From: https://github.com/assaflavie/vim 
"
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" =============================================================================
" local_vimrc.vim

" Example: setlocal path=.,subdir/,/usr/include,,"
let g:local_vimrc = ['.git/vimrc_local.vim']

func! EditLocalVimrc()
  exec ":edit .git/vimrc_local.vim"
endfun

command! -bar EditLocalVimrc call EditLocalVimrc()

" File is not checked-in on purpose:
if filereadable(expand("~/.vim_runtime/project-specific.vim"))
  " examples:
  " call lh#local_vimrc#munge('whitelist', $HOME.'<some-path>')
  " map <leader><tab>m :tabedit <some-path><CR>
  runtime project-specific.vim
endif

nmap <leader>eL :EditLocalVimrc<CR>

" =============================================================================
" CTRL-P

let g:ctrlp_working_path_mode = 0
let g:ctrlp_mruf_max = 400
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_map = '<c-f>'
noremap <leader>j :CtrlP<CR>

" We use C-c instead of C-b because we run under tmux
noremap <C-c> :CtrlPBuffer<CR>

let g:ctrlp_max_height = 19
let g:ctrlp_path_sort = 1
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

" Open selection in new tab using <CTRL+ENTER> or <SHIFT+ENTER>
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<c-x>', '<c-s>'],
      \ 'AcceptSelection("t")': ['<c-t>', '<c-cr>','<s-cr>'],
      \ }

" =============================================================================
" Snipmate

imap <C-q> <Plug>snipMateNextOrTrigger
smap <C-q> <Plug>snipMateNextOrTrigger
imap <C-j> <Plug>snipMateNextOrTrigger
smap <C-j> <Plug>snipMateNextOrTrigger
nnoremap <leader>sm :SnipMateOpenSnippetFiles<CR>

" =============================================================================
" Commentary

xmap <C-r> gc

" =============================================================================
" NERDTree

let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=35
let NERDTreeShowHidden=0
let NERDTreeQuitOnOpen=1

nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nb :NERDTreeFromBookmark<Space>
nnoremap <leader>nf :NERDTreeFind<CR>

" =============================================================================
" Shortcuts for surround.vim

map <leader>i] ysiw]
map <leader>i- ysiw-
map <leader>i' ysiw'
map <leader>i" ysiw"

vmap ( S)
vmap [ S]
vmap { S{
vmap } S}

" Surround with {}, unit with pervious line, fix indentation and edit single statement
" inside the new {} block.
nmap e{ <C-Space>{<Up>J<End><C-Space><Down><Down>=<Down>0:call JoinLinesIfBracketElse()<CR>
vmap e{ {<Up>J<End><C-Space><Down><Down>=<Down>0:call JoinLinesIfBracketElse()<CR>

" Surround the two single-line two bodies of an if-else in C with '{}'.
"
" if (...)             if (...) {
"     a;                   a;
" else          to:    } else {
"     b;                   b;
"                      }
"
nmap e2{ e{<Down><Down>e{

function! StripString(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! JoinLinesIfBracketElse() abort
  let next_line = getline(line(".") + 1)
  let following_line = getline(line(".") + 2)
  let pos = getpos(".")
  if StripString(next_line) == "}" && StripString(following_line) == "else"
    execute "normal! jJ"
  endif
  call setpos(".", pos)
endfunction

" =============================================================================
" ALE (syntax checker)

let g:ale_rust_cargo_use_check = 0
let g:ale_change_sign_column_error = 1
let g:ale_set_highlights = 1
let g:ale_linters = {}
let g:ale_set_balloons = 1
let g:ale_linters.c = ['pac']
let g:ale_linters.cpp = ['pac']

" =============================================================================
" lightline with ALE integration

let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'relativepath', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['linter_warnings', 'linter_errors', 'linter_ok', 'percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK',
      \ },
      \ 'component_type': {
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'ok',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:nr = l:counts.warning + l:counts.info
  return l:nr == 0 ? '' : printf('%d ◆', l:nr)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:nr = l:counts.error
  return l:nr == 0 ? '' : printf('%d ✗', l:nr)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

augroup ALELintUpdateLightline
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END

" =============================================================================
" Config for auto-pairs

let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsCenterLine = ''

" =============================================================================
" Bash like keys for the command line
cnoremap <C-A>	<Home>
cnoremap <C-E>	<End>
cnoremap <C-K>	<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" =============================================================================
" Shortcuts for adding pairs of parenthesis/bracket
vnoremap <A-1> <Esc>`>a)<Esc>`<i(<Esc>
vnoremap <A-2> <Esc>`>a]<Esc>`<i[<Esc>
vnoremap <A-3> <Esc>`>a}<Esc>`<i{<Esc>
vnoremap <A-4> <Esc>`>a"<Esc>`<i"<Esc>
vnoremap <A-q> <Esc>`>a'<Esc>`<i'<Esc>
vnoremap <A-e> <Esc>`>a"<Esc>`<i"<Esc>

" Map auto complete of (, ", ', [
inoremap <A-1> ()<Esc>i
inoremap <A-2> []<Esc>i
inoremap <A-3> {}<Esc>i
inoremap <A-4> {<Esc>o}<Esc>O
inoremap <A-q> ''<Esc>i
inoremap <A-d> ""<Esc>i

" Map auto complete of (, ", ', [
nnoremap <A-1> i()<Esc>i
nnoremap <A-2> i[]<Esc>i
nnoremap <A-3> i{}<Esc>i
nnoremap <A-4> i{<Esc>o}<Esc>O
nnoremap <A-q> i''<Esc>i
nnoremap <A-d> i""<Esc>i

" =============================================================================
" Various Per-Buffeer mapping overrides

function! SetPerBufferMappings() abort
  " Prevent certain actions in various buffers
  if &filetype ==# 'qf' || &filetype ==# 'nerdtree'
    map <buffer> <leader>o <nop>
    map <buffer> <C-F2> <nop>
  endif
  if &filetype ==# 'bufexplorer'
    map <buffer> <tab>q <nop>
  endif
  if &filetype ==# 'nerdtree'
    map <buffer> <tab>o <nop>
  endif
endfunction

augroup PerBufferActions
  autocmd!

  autocmd FileType * call SetPerBufferMappings()
  autocmd BufNewFile * call SetPerBufferMappings()
augroup END


" =============================================================================
" Yanking and pasting

" Copy a string to all the system's clipbard (Linux has three, and that's a
" bit confusing).
function! SetSystemClipboard(string) abort
  let l:display = expand("$DISPLAY")
  if l:display != "" && executable("xsel")
    call system('xsel -i -p', a:string)
    call system('xsel -i -s', a:string)
    call system('xsel -i -b', a:string)
  endif
endfunction

" Saner yanking and pasting behavior using <A-p> and <C-A-p>:
"
" * When yanking, put the cursor right after the yanked region, whether was
"   yanked in visual mode (lines or not).
" * When pasting, put the cursor either at the beginning of the pasted text or
"   after its end.
" * Manage a yank stack in g:my_yank_list, and allow to pick and paste from
"   from it using tlib, and changing the yank register to the picked option.
"
let g:my_yank_list = []
function! SpecialAfterYank() abort
  if @@[strlen(@@) - 1] !=# "\n" || visualmode() ==# 'V'
    " This requires virtualedit=onemore
    execute "normal! l"
  endif
  let l:text = getreg("\"")
  call insert(g:my_yank_list, l:text, 0)
  if len(g:my_yank_list) >= 100
    call remove(g:my_yank_list, 99)
  endif
  call SetSystemClipboard(l:text)
endfunction

function! PasteBeforeHack() abort
  let l:line = getcurpos()[1]
  let l:col = getcurpos()[2]
  execute "normal! P"
  call cursor(l:line, l:col)
endfunction

function! SwitchYank(paste) abort
  let l:x = tlib#input#List('si', 'Select', g:my_yank_list)
  if l:x > 0
    let l:text = g:my_yank_list[l:x - 1]
    call remove(g:my_yank_list, x - 1)
    call insert(g:my_yank_list, l:text, 0)
    let @" = l:text
    if a:paste == 1
      execute "normal! gP"
    endif
    return l:text
  endif
endfunction

vnoremap <silent> y y`]:call SpecialAfterYank()<CR>
vnoremap <silent> d d:call SpecialAfterYank()<CR>
nnoremap <silent> dd dd:call SpecialAfterYank()<CR>
nnoremap <silent> <A-y> :call SwitchYank(0)<CR>
nnoremap <silent> yy yy:call SpecialAfterYank()<CR>
noremap <silent> <A-p> :call PasteBeforeHack()<CR>

inoremap <silent> <C-A-p> <C-R>"
inoremap <silent> <A-p> <Nop>
noremap <C-A-p> gP
inoremap <C-p> <c-r>=SwitchYank(0)<CR>
noremap <silent> <C-p> :call SwitchYank(1)<CR>

" =============================================================================
" Yanking to system clipboard various stuff

"Yank various pathnames relating to the current file into the system's clipboard.

function! YankCurrentFilename() abort
  call SetSystemClipboard(expand("%"))
endfunction

function! YankCurrentDirAbs() abort
  call SetSystemClipboard(expand("%:p:h"))
endfunction

noremap <silent> <leader>yf :call YankCurrentFilename()<CR>
noremap <silent> <leader>yd :call YankCurrentDirAbs()<CR>

" =============================================================================
" Paste various things

" Insert previous relative buffer filename into the current buffer
let g:previous_buffer_filename = ""
function! LeavePreviousBuffer() abort
  let g:previous_buffer_filename = expand("%")
endfunction

augroup RememberPreviousBufferFilename
  autocmd!
  autocmd BufLeave * call LeavePreviousBuffer()
augroup END

function! MyInsertRandom() abort
  execute "py import vim, random; vim.command('normal i' + str(''.join([random.choice('abcdefghijklmnopqrstuvwxyz') for i in range(10)])))"
  execute "normal! l"
endfunction

function! MyInsertRandomInInsertMode() abort
  python import random
  return pyeval("''.join([random.choice('abcdefghijklmnopqrstuvwxyz') for i in range(10)])")
endfunction

imap <A-e>f <c-r>=g:previous_buffer_filename<CR>
nmap <A-e>f i<c-r>=g:previous_buffer_filename<CR>
imap <A-e>r  <c-r>=MyInsertRandomInInsertMode()<CR>
map <A-e>r  :call MyInsertRandom()<CR>

" =============================================================================
" Execute something without the prompt

command! -nargs=1 Silent
      \   execute 'silent !' . <q-args>
      \ | execute 'redraw!'

" =============================================================================

function! OnF11() abort
  execute "ptag " . expand("<cword>")
endfunction

" =============================================================================
" Tagbar

map <F10> :Tagbar<CR>

" =============================================================================
" CInsertIncludeForTag
"
" Search for the filename containing the prototype of the function or
" type definition for a C tag, and insert '#include <filename>' in the
" current file where there is the marker `i`.
"
" if b:insert_include_prefix_remove is defined, and the filename starts
" with this prefix, then it is removed before being inserted as 'filename'.
"

function! CInsertIncludeForTag() abort
  redir => l:matches
  silent execute (":tselect " . expand("<cword>"))
  redir END
  for l:line in split(l:matches, "\n")
    let l:fields = filter(split(l:line, " "), 'v:val != ""')
    if len(l:fields) >= 5
      if l:fields[2] == 'p' || l:fields[2] == 't'
        let l:insert_include_prefix_remove = get(b:, 'insert_include_prefix_remove', "")
        let l:s = l:fields[4]
        if l:insert_include_prefix_remove != ''
          if strpart(l:s, 0, len(l:insert_include_prefix_remove)) == l:insert_include_prefix_remove
            let l:s=strpart(l:s, len(l:insert_include_prefix_remove))
          endif
        endif
        call append(line("'i"), "#include <" . l:s . ">")
        break
      endif
    endif
  endfor
endfunction

command! CInsertIncludeForTag call CInsertIncludeForTag()

" =============================================================================
" Invoking completions

" Completion
" tab to select
" and don't hijack my enter key
" inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
" inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

inoremap <C-s> <C-x><C-s>
inoremap <C-d> <C-x><C-d>
inoremap <C-l> <C-x><C-l>
inoremap <C-]> <C-x><C-]>

" =============================================================================

nnoremap <C-Space> V
if has('nvim')
  nnoremap <C-S-PageUp> V
endif
vmap <Cr> y
vnoremap <C-Cr> *``

" =============================================================================
" Syntax highlighting

" Show highlight names at cursor

function! IdentifySyn(...) abort
  echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction

command! IdentifySyn call IdentifySyn()

set termguicolors
set background=dark

function! MyHighlights() abort
  highlight cAnsiFunction  guifg=#dddd90 guibg=NONE     gui=NONE
  highlight cBraces        guifg=#ffdd80 guibg=NONE     gui=NONE
  highlight cDelimiter     guifg=#ffaa80 guibg=NONE     gui=NONE
  highlight cNumber        guifg=#ff9999 guibg=NONE     gui=NONE
  highlight cUserFunction  guifg=#ffcc90 guibg=NONE     gui=NONE

  highlight IncSearch      guifg=#000000 guibg=#ffff00  gui=bold
  highlight Search         guifg=#ccffdd guibg=#006611  gui=bold

  highlight TabLineFill    guifg=#ffffff guibg=#000000
  highlight TabLine        guifg=black   guibg=#222222
  highlight TabLineSel     guifg=#444444 guibg=#202020  gui=bold

  highlight ALEError       guibg=#770000 guifg=#ffffff
  highlight ALEErrorSign   guibg=#770000 guifg=#ff0000
  highlight ALEInfo        guibg=#774400 guifg=#ffffff
  highlight ALEInfoSign    guibg=#774400 guifg=#ff8800
  highlight ALEWarning     guibg=#777700 guifg=#ffffff
  highlight ALEWarningSign guibg=#777700 guifg=#ffff00

  highlight ExtraWhitespace ctermbg=red guibg=red
endfunction

augroup MyColors
  autocmd!

  autocmd ColorScheme * call MyHighlights()
augroup END

colorscheme peaksea-mod

" Syntax highlighting speed

"
" I noticed that default settings for syntax hilightlying drag Vim to a grind
" when ending medium-sized files.
"
" https://vi.stackexchange.com/questions/2875/vim-slows-down-over-time-with-syntax-on
"
" The difference is huge with the following:
set regexpengine=1
" I'm guessing that it depends on the type of file you're editing.

" This may also be helpful, but more experimentation is needed:

" syntax sync minlines=50

" =============================================================================
" Markdown

let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_extensions_in_markdown = 1

augroup MarkdownEditSettings
  autocmd!
  autocmd Filetype markdown map <buffer> <A-e>d  G$<right>i<CR><CR><C-R>=MyVimEditInsertDateLine()<CR><CR>
  autocmd Filetype markdown map <buffer> <leader>e\ <A-e>d
  autocmd Filetype markdown imap <buffer> <A-e>d  <C-R>=MyVimEditInsertDateLine()<CR>
  autocmd Filetype markdown map <buffer> <C-cr> <Plug>Markdown_EditUrlUnderCursor()
augroup END

" =============================================================================
" Vim editing

" Useful when doing small vimrc updates
function! VimEvalLine() abort
  execute getline(".")
  echo 'Line evaluated'
  execute "normal! gj"
endfunction

function! GetVisualSelection() abort
  " Why is this not a built-in Vim script function?!
  " https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

function! VimEvalSelected() abort range
  execute GetVisualSelection()
endfunction

function! MyVimEditSettings() abort
  setlocal ts=1 sw=2 expandtab
  nnoremap <buffer> <C-e> :call VimEvalLine()<CR>
  vnoremap <buffer> <C-e> :call VimEvalSelected()<CR>
endfunction

augroup VimEditSettings
  autocmd!
  autocmd Filetype vim call MyVimEditSettings()
augroup END

function! MyVimEditInsertDateLine() abort
  return strftime("#### At %Y-%m-%d %H:%M:%S\n")
endfunction

" =============================================================================
" Haskell

augroup HaskellEditSettings
  autocmd!
  autocmd FileType haskell setlocal smartcase
  autocmd Filetype haskell setlocal autoindent
  autocmd Filetype haskell setlocal expandtab
  autocmd Filetype haskell setlocal shiftround
  autocmd Filetype haskell setlocal shiftwidth=4
  autocmd Filetype haskell setlocal smarttab
  autocmd Filetype haskell setlocal softtabstop=4
  autocmd Filetype haskell setlocal tabstop=8
augroup END

" Python
" ==============================================================================

augroup PythonEditSettings
  autocmd!
  autocmd Filetype python setlocal autoindent
  autocmd Filetype python setlocal expandtab
  autocmd Filetype python setlocal shiftround
  autocmd Filetype python setlocal shiftwidth=4
  autocmd Filetype python setlocal smarttab
  autocmd Filetype python setlocal softtabstop=4
  autocmd Filetype python setlocal tabstop=8
augroup END

" =============================================================================
" C

" Disable vim-linux-coding-style so I can enable it explicitly, i.e call
" LinuxCodingStyle
let g:linuxsty_patterns = ['_only_used_per_tree']

function! CondLinuxCodingStyle()
  if &ft == "cpp" || &ft == 'c'
    LinuxCodingStyle
  endif
endfunction

command! CondLinuxCodingStyle call CondLinuxCodingStyle()

" Or use the other standard of indenting with 4 spaces. I mainly put these in
" a local_vimrc.

func! Indent4Spaces(...)
  setlocal expandtab

  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal nosmarttab
endfun

command! Indent4Spaces call Indent4Spaces()

" =============================================================================
" sideways.vim

nnoremap <c-x><Left>    :SidewaysLeft<CR>
nnoremap <c-x><Right>   :SidewaysRight<CR>
nnoremap <c-a><Left>    :SidewaysJumpLeft<CR>
nnoremap <c-a><Right>   :SidewaysJumpRight<CR>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" =============================================================================
" Vim-rooter

let g:rooter_patterns = ['.git', '.git/', 'Cargo.toml', 'Makefile']
let g:rooter_change_directory_for_non_project_files = 'current'

" =============================================================================
" Grepper

nnoremap <F9> :Grepper -noprompt -cword<CR>
nnoremap <C-F9> :Grepper -cword<CR>

let g:grepper = {
      \ 'tools': ['git', 'grep'],
      \ 'quickfix' : 1,
      \ 'stop' : 50000,
      \ }


" =============================================================================
" Git-related stuff

let g:gitgutter_highlight_lines = 0
set updatetime=400

function! MySplitGitMode(command) abort
  let l:path = fugitive#extract_git_dir(expand('%:p'))
  vertical botright new
  call FugitiveDetect(l:path)
  execute a:command
  wincmd p
endfunction

function! MyGitShowHead() abort
  call MySplitGitMode("Gedit @")
endfunction

command! SplitGitHEAD call MyGitShowHead()

function! MyGitCommitHook() abort
  nnoremap <buffer> <C-g> :call MyGitShowHead()<CR>
endfunction

augroup GitCommitRebinding
  autocmd!
  autocmd! FileType gitcommit call MyGitCommitHook()
augroup END

nmap <leader>gdh :call gv#diff('HEAD')<CR>
nmap <leader>gdc :call gv#diff('--cached', 'HEAD')<CR>
nmap <leader>gdch :call gv#diff('--cached')<CR>
nmap <leader>gl :!git log
nmap <leader>gh :SplitGitHEAD<CR>
nmap <leader>gst :silent Gstatus<CR>
nmap <leader>grb- :!git rebase<CR>
nmap <leader>grbi :!git rebase -i<CR>

nmap <leader>hu :GitGutterUndoHunk<CR>
nnoremap <C-h><Delete> :GitGutterUndoHunk<CR>:w<CR>
nmap <C-h><Down> <Plug>GitGutterNextHunk
nmap <C-h><Up> <Plug>GitGutterPrevHunk
inoremap <C-h><Delete> <C-c>:GitGutterUndoHunk<CR>:w<CR>
imap <C-h><Down> <C-c><Plug>GitGutterNextHunk
imap <C-h><Up> <C-c><Plug>GitGutterPrevHunk

function! MyGitRebaseTodoHook(...) abort
  call setpos('.', [0, 1, 1, 0])
  nnoremap <buffer> p 0ciwpick<ESC><Down>0
  nnoremap <buffer> r 0ciwreword<ESC><Down>0
  nnoremap <buffer> e 0ciwedit<ESC><Down>0
  nnoremap <buffer> s 0ciwsquash<ESC><Down>0
  nnoremap <buffer> f 0ciwfixup<ESC><Down>0
  nnoremap <buffer> x 0ciwexec<ESC><Down>0
  nnoremap <buffer> d 0ciwdrop<ESC><Down>0
  nnoremap <buffer> k 0ciwdrop<ESC><Down>0
  nmap <buffer> <C-Up> <M-k>
  nmap <buffer> <C-Down> <M-j>
  nmap <buffer> <M-PageUp> <M-k>
  nmap <buffer> <M-PageDown> <M-j>
endfunction

augroup GitRebaseTodoRebinding
  autocmd!
  autocmd! BufRead git-rebase-todo call MyGitRebaseTodoHook()
augroup END

" =============================================================================
" Emacs migration path:

nnoremap <C-z> :undo<CR>
inoremap <C-z> <ESC>:undo<CR>i
nnoremap <silent> <C-x>f :NERDTreeFind<CR>
nmap <Esc>x <Nop>

" Saving or quiting from anywhere
noremap <C-x>s <C-c>:w<CR>
noremap <C-x><C-s> <C-c>:w<CR>
noremap! <C-x>s <C-c>:w<CR>
noremap! <C-x><C-s> <C-c>:w<CR>
noremap <C-x>q <C-c>:q<CR>
noremap <C-x><C-q> <C-c>:q<CR>
noremap! <C-x>q <C-c>:q<CR>
noremap! <C-x><C-q> <C-c>:q<CR>

" =============================================================================
" Language server

let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ }

let g:LanguageClient_autoStart = 1

" Stuff I am not using yet:

" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" =============================================================================
" Config for vim-highlightedyank

let g:highlightedyank_highlight_duration = 200

hi HighlightedyankRegion guibg=#008080 gui=NONE term=NONE

" =============================================================================
" Misc

let g:qf_auto_resize = 0
let g:qf_window_bottom = 0
let g:qf_mapping_ack_style = 1

noremap <silent> <F8>   :Explore<CR>
noremap <silent> <S-F8> :sp +Explore<CR>

" Look for a man page
map <C-F1> <Plug>(Man)

" Goodbye!
" =============================================================================
