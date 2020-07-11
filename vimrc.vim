" =============================================================================
" Welcome!

" Some original work, plus some bits from: https://github.com/amix/vimrc
" Others from https://github.com/jonhoo/configs/blob/master/.vimrc

" =============================================================================
" # PLUGINS
" =============================================================================

call plug#begin('~/.vim_runtime/vim-plugged')

" File is not checked-in on purpose:
if filereadable(expand('~/.vim_runtime/project-specific-premable.vim'))
  runtime project-specific-premable.vim
endif

" Libs
Plug 'LucHermitte/lh-vim-lib'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'vim-scripts/tlib'

"" Settings
Plug 'LucHermitte/local_vimrc'
Plug 'airblade/vim-rooter'

" Navigation and other state manipulation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-abolish'
Plug 'dhruvasagar/vim-zoom'

" Text manipulation
Plug 'AndrewRadev/sideways.vim'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'FooSoft/vim-argwrap'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'matze/vim-move'

let g:my_name_assign_devel = get(g:, 'my_name_assign_devel', '')
if g:my_name_assign_devel !=# ''
  Plug 'da-x/name-assign.vim' , { 'dir': g:my_name_assign_devel }
else
  Plug 'da-x/name-assign.vim'
endif

" Snipppets
Plug 'SirVer/ultisnips'

" Git
Plug 'da-x/vim-gitgutter' , { 'branch': 'allow-clobber' }
Plug 'da-x/gv.vim'
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/gina.vim'
Plug 'jreybert/vimagit'
Plug 'da-x/conflict-marker.vim'
Plug 'da-x/vim-git-conflict-edit'

" Visual effects
Plug 'machakann/vim-highlightedyank'

" Themes
Plug 'itchyny/lightline.vim'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'google/vim-searchindex'
Plug 'justinmk/vim-sneak'

" RPC and completions
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'ncm2/ncm2'

" Syntax related
Plug 'godlygeek/tabular'
Plug 'vivien/vim-linux-coding-style'
Plug 'cespare/vim-toml'
Plug 'bronson/vim-trailing-whitespace'

" Markdown management
Plug 'da-x/vim-markdown'

"
" Allow to override the directory from the command line, sourcing a
" developemnt tree of rust.vim.
"
"    vim --cmd 'let g:my_rust_vim_devel = $HOME."/gh/FORKS/rust.vim"'
"
let g:my_rust_vim_devel = get(g:, 'my_rust_vim_devel', '')
if g:my_rust_vim_devel !=# ''
  Plug 'rust-lang/rust.vim' , { 'dir': g:my_rust_vim_devel }
else
  Plug 'rust-lang/rust.vim'
endif

Plug 'rhysd/rust-doc.vim'

Plug 'justinmk/vim-syntax-extra'
Plug 'vimoutliner/vimoutliner'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'editorconfig/editorconfig-vim'

" Language related (checkers and suggest)

if system("uname -m") != "aarch64"
  Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
endif

let g:my_ale_devel = get(g:, 'my_ale_devel', '')
if g:my_ale_devel !=# ''
  Plug 'w0rp/ale' , { 'dir': g:my_ale_devel }
else
  Plug 'w0rp/ale'
endif
Plug 'vim-syntastic/syntastic'

" Other
Plug 'junegunn/vader.vim'
Plug 'Shougo/echodoc.vim'

call plug#end()

" =============================================================================
" Terminal fixups

" Various missing ansi code mappings, plus special mappings that are intrinsic
" to how I configure Alacritty. Some bindings are for Vim, others for NeoVim.

map <Char-0x0c> :call OnF11()<CR>
map <Char-0x1c> :call OnCtrlBar()<CR>
map <Char-0x1f> :call OnCtrlMinus()<CR>

map <ESC><Char-0x10> <C-A-p>
map! <ESC><Char-0x10> <C-A-p>

map <ESC>[11;3~ <A-F1>
map! <ESC>[11;3~ <A-F1>
map <ESC>[11;5~ <C-F1>
map! <ESC>[11;5~ <C-F1>
map <ESC>[1;5P <C-F1>
map! <ESC>[1;5P <C-F1>
map <ESC>[11;6~ <C-S-F1>
map! <ESC>[11;6~ <C-S-F1>
map <F25> <C-F1>
map! <F25> <C-F1>

map <ESC>[12;3~ <A-F2>
map! <ESC>[12;3~ <A-F2>
map <ESC>[1;5Q  <C-F2>
map! <ESC>[1;5Q <C-F2>
map <ESC>[12;5~ <C-F2>
map! <ESC>[12;5~ <C-F2>
map <ESC>[12;6~ <C-S-F2>
map <ESC>[1;2Q  <C-S-F2>
map! <ESC>[12;6~ <C-S-F2>
map <F26> <C-F2>
map! <F26> <C-F2>

map <ESC>[13;3~ <A-F3>
map! <ESC>[13;3~ <A-F3>
map <ESC>[13;5~ <C-F3>
map! <ESC>[13;5~ <C-F3>
map <ESC>[1;5R  <C-F3>
map! <ESC>[1;5R <C-F3>
map <ESC>[13;6~ <C-S-F3>
map <ESC>[1;2R  <C-S-F3>
map! <ESC>[13;6~ <C-S-F3>
map <F27> <C-F3>
map! <F27> <C-F3>

map <ESC>[14;3~ <A-F4>
map! <ESC>[14;3~ <A-F4>
map <ESC>[14;5~ <C-F4>
map! <ESC>[14;5~ <C-F4>
map <ESC>[1;5S <C-F4>
map! <ESC>[1;5S <C-F4>
map <ESC>[14;6~ <C-S-F4>
map! <ESC>[14;6~ <C-S-F4>
map <F28> <C-F4>
map! <F28> <C-F4>

map <ESC>[3;5~ <C-Delete>
map! <ESC>[3;5~ <C-Delete>

map <ESC>[5;30001~ <S-CR>
map! <ESC>[5;30001~ <S-CR>
map <ESC>[5;30002~ <A-CR>
map! <ESC>[5;30002~ <A-CR>
map <ESC>[5;30003~ <C-CR>
map! <ESC>[5;30003~ <C-CR>
map <ESC>[5;30004~ <C-S-s>
map! <ESC>[5;30004~ <C-S-s>
map <ESC>[5;30005~ <C-A-CR>
map! <ESC>[5;30005~ <C-A-CR>
map <ESC>[5;30014~ <C-Space>
map! <ESC>[5;30014~ <C-Space>

map <ESC>[Z <S-tab>
map <ESC>a <A-a>
map <ESC>h <A-h>
map <ESC>r <A-r>
map <ESC>w <A-w>

map <ESC>j <M-j>
map! <ESC>j <M-j>
map <ESC>k <M-k>
map! <ESC>k <M-k>
map <ESC>p <A-p>
map! <ESC>p <A-p>
map <ESC>t <A-t>
map <ESC>1 <A-1>
map! <ESC>1 <A-1>
map <ESC>2 <A-2>
map! <ESC>2 <A-2>
map <ESC>3 <A-3>
map! <ESC>3 <A-3>
map <ESC>4 <A-4>
map! <ESC>4 <A-4>
map <ESC>q <A-q>
map! <ESC>q <A-q>
map <ESC>y <A-y>
map! <ESC>y <A-y>
map <ESC>e <A-e>
map! <ESC>e <A-e>
map <ESC>d <A-d>
map! <ESC>d <A-d>
map <ESC>g <A-g>
map! <ESC>g <A-g>

map <ESC>[4~ <End>
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

" Sign column
try
  silent! set signcolumn=auto:4
endtry

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

" Reload environment from tmux (useful after attaching, when $DISPLAY changes
" and you want the X clipboard interaction to work properly across ssh).
function! ReloadEnvironment() abort
  if $TMUX ==# ''
    return
  endif

  silent let l:env = system('tmux show-environment')
  for l:line in split(l:env, '\n')
    if l:line =~# '\V\^-\(\.\*\)'
      " Only possible with 8.0.1832 [ https://github.com/vim/vim/issues/1116 ]
      silent! execute 'unlet $'.strpart(l:line, 1)
    else
      let [l:name, l:value] = split(l:line, '=')
      execute 'let $'.l:name." = \"".escape(l:value, '\\/.*$^~[]')."\""
    endif
  endfor
endfunction

func TimerCallback_ReloadEnvironenment(timer)
  call ReloadEnvironment()
endfunc

let timer = timer_start(60000,
      \ 'TimerCallback_ReloadEnvironenment', {'repeat': -1})

if !exists("*ReloadVimConfig")
  function! ReloadVimConfig()
    source $MYVIMRC
  endfunction
endif

command! ReloadVimConfig call ReloadVimConfig()

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

" Disable ex mode, I keep entering it by mistake, and I never use it.
map q: <Nop>

" =============================================================================
" Various single-line shortcuts

" Fast saving
nnoremap <leader>w :w!<CR>

" Close buffer
nnoremap <tab>r :bd<CR>

" No need for entering shift when going into command mode
nnoremap ; :

" Quickly switch to other buffer
nnoremap <leader><leader> <c-^>

" Disable highlight when <leader><CR> is pressed
map <silent> <leader><CR> :noh<CR>

" =============================================================================
" Various mappings for function keys

nnoremap <leader><F1> :help vim-runtime<CR>
nmap <F2> :Buffers<CR>
map! <F2> <Nop>
imap <F2> <C-c><F2>
nmap <C-F2> :History<CR>
map! <C-F2> <Nop>
imap <C-F2> <C-c><C-F2>
nmap <C-S-F2> :GFiles<CR>
map! <C-S-F2> <Nop>
imap <C-S-F2> <C-c><C-F2>
nmap <F3> :NERDTreeFind<CR>
map! <F3> <Nop>
imap <F3> <C-c><F3>
nmap <C-F3> :NERDTreeToggle<CR>
map! <C-F3> <Nop>
imap <C-F3> <C-c><F3>
nmap <C-S-F3> :BCommits<CR>
map! <C-S-F3> <Nop>
imap <C-S-F3> <C-c><F3>
nmap <S-F3> <C-S-F3>
map! <S-F3> <C-S-F3>
imap <S-F3> <C-S-F3>

" Navigate location lists
nmap <F4> :lnext<CR>
map! <F4> <Nop>
imap <F4> <C-c><F4>
nmap <M-F4> :lprev<CR>
map! <M-F4> <Nop>
imap <M-F4> <C-c><M-F4>
nmap <C-S-F4> :lprev<CR>
map! <C-S-F4> <Nop>
imap <C-S-F4> <C-c><C-F4>
nmap <C-F4> :lfirst\|lopen<CR>
map! <C-F4> <Nop>
imap <C-F4> <C-c><C-F4>
nmap <S-F4> <C-S-F4>
map! <S-F4> <C-S-F4>
imap <S-F4> <C-S-F4>

" Navigate the quickfix list
nmap <F5> :cnext<CR>
map! <F5> <Nop>
imap <F5> <C-c><F5>
nmap <M-F5> :cprev<CR>
map! <M-F5> <Nop>
imap <M-F5> <C-c><M-F5>
nmap <C-S-F5> :cprev<CR>
map! <C-S-F5> <Nop>
imap <c-S-F5> <C-c><M-F5>
nmap <C-F5> :cfirst\|copen<CR>
map! <C-F5> <Nop>
imap <C-F5> <C-c><C-F5>
nmap <S-F5> <C-S-F5>
map! <S-F5> <C-S-F5>
imap <S-F5> <C-S-F5>

" Quickly record a macro and execute it

function! OnOffRecord() abort
  if reg_recording() == ""
    normal qm
  else
    normal q
  endif
endfunction

nnoremap <silent> <C-F7> :call OnOffRecord()<CR>
nnoremap <silent> <F7> @m

imap <C-F7> <C-c><C-F7>

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
" And in select mode, affect selection
vnoremap <C-d> "_d

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

function! InsertSelectionMatch() abort
  " Return the first match of the current highlight
  let l:save_pos = getpos('.')
  let l:search_mark = @/
  let l:res = l:search_mark
  let [l:lnum, l:col] = searchpos(@/, 'cw')

  if l:lnum !=# 0
    let [l:lnum_end, l:col_end] = searchpos(@/, 'ce')
    if l:lnum ==# l:lnum_end
      let l:res = escape(strpart(getline(l:lnum), l:col - 1, l:col_end - l:col + 1), ' /&')
    else
      " Not supported yet
    endif
  endif

  call setpos('.', l:save_pos)
  return l:res
endfunction

" Search and replace using the current search mark, either in a selection or
" the entire buffer, and take the closest match as the replacement text to
" edit.
nnoremap <A-r> :%s/<C-r>=@/<CR>/<C-r>=InsertSelectionMatch()<CR>/g<left><left>
vnoremap <A-r> :s/<C-r>=@/<CR>/<C-r>=InsertSelectionMatch()<CR>/g<left><left>

" Same as above, but write a new string for replacement.
nnoremap <A-n> :%s/<C-r>=@/<CR>//g<left><left>
vnoremap <A-n> :s/<C-r>=@/<CR>//g<left><left>
nnoremap <leader>x :/<C-r>=@/<CR>

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

command! TrimWhiteSpace call TrimWhiteSpace()

" =============================================================================

function! RexSignal(chan) abort
  let l:helper = "$HOME/.vim_runtime/bin/rex"
  let l:cmd = l:helper . ' signal' . string(a:chan)
  if exists(l:helper)
    execute ":wa"
    silent call system(l:helper . ' signal ' . string(a:chan), "")
  endif
endfunction

nmap <leader>1 :call RexSignal(1)<CR>
nmap <leader>2 :call RexSignal(2)<CR>
nmap <leader>3 :call RexSignal(3)<CR>

" =============================================================================
" NEDTRee

let NERDTreeIgnore = ['\.pyc$', '\.o$']

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

" Expand region settiings
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :1,
      \ 'i''' :1,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }

" =============================================================================

nnoremap <leader>sq :ArgWrap<CR>
let g:argwrap_tail_comma = 1

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
nmap <C-f> /

" =============================================================================
" Disable vim-unimpaired for normal mode

let g:nremap = {}

" =============================================================================
" Shortcuts for quickly opening various config files

nnoremap <leader>ea :e! ~/.config/alacritty/alacritty.yml<CR>
nnoremap <leader>ee :e! ~/.vim_runtime/vimrc.vim<CR>
nnoremap <leader>eg :e! ~/.files/gitconfig<CR>
nnoremap <leader>et :e! ~/.tmux.conf<CR>
nnoremap <leader>ez :e! ~/.zsh/zshrc.sh<CR>
nnoremap <leader>e_ :e! ~/.vim_runtime/project-specific.vim<CR>

function! AdjacentOrMetaOpen(file) abort
  let l:adjacent = expand('%:p:h')."/".a:file
  if filereadable(l:adjacent)
    execute 'e! ' . l:adjacent
  else
    let l:metadir = MyGitRoot() . "/.git/meta"
    if isdirectory(l:metadir)
      let l:metafile = l:metadir."/".a:file
      execute 'e! ' . l:metafile
    else
      echom "Meta directory ".l:metadir." does not exist"
    endif
  endif
endfunction

nnoremap <silent> <leader>ed :call AdjacentOrMetaOpen("todo.md")<CR>
nnoremap <silent> <leader>ev :call AdjacentOrMetaOpen("design.md")<CR>
nnoremap <silent> <leader>el :call AdjacentOrMetaOpen("log.md")<CR>

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

nmap <Tab>m <Plug>(zoom-toggle)

" Splitting windows
function! OnCtrlBar() abort
  exec "vsplit"
endfunction

function! OnCtrlMinus() abort
  exec "split"
endfunction

function! OnVimResized() abort
  wincmd =
endfunction

augroup VimResizeAU
  autocmd!
  autocmd VimResized * call OnVimResized()
augroup END

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
" Tabs

map <leader><right> :tabn<cr>
map <leader><left> :tabp<cr>

" =============================================================================
" local_vimrc.vim

" Example: setlocal path=.,subdir/,/usr/include,,"
let g:local_vimrc = ['.git/vimrc_local.vim']

func! EditLocalVimrc()
  exec ":edit .git/vimrc_local.vim"
endfun

command! -bar EditLocalVimrc call EditLocalVimrc()

nmap <leader>eL :EditLocalVimrc<CR>

" =============================================================================
" Helpers for editing vim_runtime's own doc/ directory

func! MyHelpAutoCmds()
  command! -bar Edit execute "set filetype=txt modifiable" | w!
endfunc

augroup HelpAutocmds
  autocmd!
  autocmd! FileType help call MyHelpAutoCmds()
augroup END

" =============================================================================
" CTRL-P

let g:ctrlp_working_path_mode = 0
let g:ctrlp_mruf_max = 400
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_map = ''
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
" UltiSnip

let g:UltiSnipsExpandTrigger = '<c-q>'
let g:UltiSnipsListSnippets = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-e>'
let g:UltiSnipsJumpBackwardTrigger = '<c-f>'
let g:UltiSnipsRemoveSelectModeMappings = 0
inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

function! MyEditUltiSnips()
  let l:filename = '~/.vim_runtime/UltiSnips/'.&filetype.'.snippets'
  execute 'edit ' . l:filename
endfunction

map <leader>sm :call MyEditUltiSnips()<cr>

" =============================================================================
" NameAssign + vim-textobj-parameter

" Quickly extrcat a parameter of a function to an assignment

nmap <A-=> vi,<A-=>

" =============================================================================
" Commentary

xmap <C-r> gc

" =============================================================================
" NERDTree

let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=35
let g:NERDTreeShowHidden=0
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeCustomOpenArgs =
      \ {'file': {'reuse': 'all', 'where': 'p', 'keepopen':0, 'stay':0}}

nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nb :NERDTreeFromBookmark<Space>
nnoremap <leader>nf :NERDTreeFind<CR>

" =============================================================================
" Shortcuts for surround.vim

map <leader>i] ysiw]
map <leader>i- ysiw-
map <leader>i' ysiw'
map <leader>i" ysiw"

vmap <A-'> S'
vmap <A-,> S>
vmap " S"
vmap ( S)
vmap [ S]
vmap { S{
vmap } S}
vmap :< S<
vmap :> S>

" Surround with {}, unit with pervious line, fix indentation and edit single statement
" inside the new {} block.
nmap <leader>s{ <C-Space>{<Up>J<End><C-Space><Down><Down>=<Down>0:call JoinLinesIfBracketElse()<CR>
vmap <leader>s{ {<Up>J<End><C-Space><Down><Down>=<Down>0:call JoinLinesIfBracketElse()<CR>

" Surround the two single-line two bodies of an if-else in C with '{}'.
"
" if (...)             if (...) {
"     a;                   a;
" else          to:    } else {
"     b;                   b;
"                      }
"
nmap <leader>s2{ e{<Down><Down>e{

function! NewCurlyGroupFromWord() abort
  normal +}
  let [_, l:line_a, l:col_a, _ ] = getpos(".")
  call setpos(".", [_, l:line_a, l:col_a + 1])
  execute "normal! i,\<Space>"
  call setpos(".", [_, l:line_a, l:col_a + 1])
  startinsert
endfunction

nmap <silent> <leader>s+ :call NewCurlyGroupFromWord()<CR>

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
" Rust

" let g:rustfmt_autosave_if_config_present = 1

let g:rustfmt_autosave = 0
let g:rustfmt_autosave_if_config_present = 0
let g:rustfmt_autosave_because_of_config = 0
let g:rust_doc#downloaded_rust_doc_dir = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu'

" =============================================================================
" Syntastic

" Disable it by default because we are using ALE
augroup MyVimEnterForSyntastic
  autocmd!
  autocmd VimEnter * silent SyntasticToggleMode
augroup END

let g:syntastic_auto_loc_list = 1

" =============================================================================
" ALE (syntax checker)

let g:ale_rust_ignore_secondary_spans = 1
let g:ale_set_highlights = 1
let g:ale_set_balloons = 1
let g:ale_virtualtext_cursor = 1
let g:ale_linters = {}
let g:ale_linters.c = ['pac']
let g:ale_linters.cpp = ['pac']
let g:ale_linters.markdown = []

" =============================================================================
" lightline with ALE integration

let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'relativepath', 'modified'] ],
      \   'right': [ [ 'filetype', 'lineinfo'],
      \              ['linter_warnings', 'linter_errors', 'linter_ok', 'percent'] ]
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
" Bash like keys for the command line
cnoremap <C-A>	<Home>
cnoremap <C-E>	<End>
cnoremap <C-K>	<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" =============================================================================
" Shortcuts for adding pairs of parenthesis/bracket

" Map auto complete of (, ", ', [
inoremap <A-1> ()<Esc>i
inoremap <A-2> []<Esc>i
inoremap <A-3> {}<Esc>i
inoremap <A-4> {<Esc>o}<Esc>O
inoremap <A-q> ''<Esc>i
inoremap <A-d> ""<Esc>i

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
  let l:display = system('echo $DISPLAY')
  " For some reason expand("$DISPLAY") does not work only from a markdown
  " buffer (WTF?).

  if l:display !=# ''
    let l:helper = '$HOME/.vim_runtime/bin/set-all-clipboard.py'
    if exists(l:helper)
      if has('nvim')
        " Send it to the background, because it may take some time due to
        " a remote tmux session.
        let l:id = jobstart(l:helper, {'on_exit': function('s:BackgroundSetClip_JobEnd')})
        let s:clip_jobstart_time = reltimefloat(reltime())
        call chansend(l:id, a:string)
        call chanclose(l:id, 'stdin')
      else
        silent call system(l:helper, a:string)
      endif
    else
      silent call system('xsel -i -p', a:string)
      silent call system('xsel -i -s', a:string)
      silent call system('xsel -i -b', a:string)
    endif
  endif
endfunction

function! s:BackgroundSetClip_JobEnd(job_id, exit_code, event_type) abort
  let l:clip_job_end_time = reltimefloat(reltime())
  let l:duration = l:clip_job_end_time - s:clip_jobstart_time
  if a:exit_code != 0
    echo '<ERROR copying to system clipboard: '.string(a:exit_code).'>'
  else
    if l:duration > 0.2
      echo '<copied to system clipboard (jobid='.string(a:job_id).')>'
    endif
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
  let l:repr_list = []
  for l:i in g:my_yank_list
    call add(l:repr_list, string(l:i))
  endfor
  let l:x = tlib#input#List('si', 'Select', l:repr_list)
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

augroup WorkaroundNeovimIssue7994
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

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
" Pasting 'hugs'
"
" Given a special marker pattern ('<HUGS>'), plus a current content of the
" default register, plus a visual selection, paste before and after the
" selection, i.e., hug it.
"
" For example:
"
"     Register content: Start<HUG>End
"
" Before action:
"
"     Hello World
"        ~~
"        (visually selected)
"
" After action:
"
"     HelStartloEnd World
"                  |

let g:hug_marker = '\V<HUG>'

function! PasteHug() abort range
  let l:text = getreg("")
  let l:delimiters = split(l:text, g:hug_marker)
  if len(l:delimiters) != 2
    return
  endif
  let [_, l:line_a, l:col_a, _ ] = getpos("'<")
  let [_, l:line_b, l:col_b, _ ] = getpos("'>")
  if l:line_a == l:line_b
    let l:line = getline(l:line_a)
    let l:part = strpart(l:line, l:col_a - 1, l:col_b - l:col_a + 1)
    let [l:start, l:end] = l:delimiters
    call setline(l:line_a, strpart(l:line, 0, l:col_a - 1) . l:start . l:part . l:end . strpart(l:line, l:col_b))
    call setpos(".", [0, l:line_a, l:col_b + strlen(l:end) + strlen(l:start) + 1, 0])
  else
    " Not implemented
  endif
endfunction

command! -range -nargs=* PasteHug :<line1>,<line2>call PasteHug()

vnoremap <silent> <A-e>h :PasteHug<CR>
noremap <silent>  <A-e>w viw:PasteHug<CR>

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
  execute "pyx import vim, random; vim.command('normal i' + str(''.join([random.choice('abcdefghijklmnopqrstuvwxyz') for i in range(10)])))"
  execute "normal! l"
endfunction

function! MyInsertRandomInInsertMode() abort
  python import random
  return pyxeval("''.join([random.choice('abcdefghijklmnopqrstuvwxyz') for i in range(10)])")
endfunction

imap <A-e>f <c-r>=g:previous_buffer_filename<CR>
nmap <A-e>f i<c-r>=g:previous_buffer_filename<CR>
imap <A-e>r  <c-r>=MyInsertRandomInInsertMode()<CR>
map <A-e>r  :call MyInsertRandom()<CR>

" =============================================================================
" Execute something without the prompt

function! MyPythonSnippet(...) abort
  let l:name = a:1
  let l:filename = g:pymacros_path.'/' . l:name . '.py'

  if !exists('s:pymacros_init')
    let s:pymacros_init = 1
    execute 'pyx import sys, os; sys.path.append("'.g:pymacros_path.'")'
    execute 'pyx import importlib'
  endif

  if filereadable(l:filename)
    execute 'pyx import ' . l:name
    execute 'pyx importlib.reload(' . l:name . ')'
    execute 'pyx import ' . l:name . ' ; ' . l:name . '.main(*list(vim.eval("a:000"))[1:])'
  else
    echom "Pymacro does not exist"
  endif
endfunction

function! MyPythonSnippetEdit(...) abort
  let l:name = a:1
  let l:filename = g:pymacros_path.'/' . l:name . '.py'
  execute 'edit ' . l:filename
endfunction

function! MyPythonSnippetList(...) abort
  // TODO
endfunction

command! -nargs=+ Pym call MyPythonSnippet(<f-args>)
command! -nargs=1 PymList call MyPythonSnippetList()
command! -nargs=1 PymEdit call MyPythonSnippetEdit(<q-args>)

" =============================================================================
" Execute something without the prompt

command! -nargs=1 Silent
      \   execute 'silent !' . <q-args>
      \ | execute 'redraw!'

" =============================================================================

function! CatQF(cmd) abort
  let l:matches = []

  for l:line in systemlist(a:cmd)
    let l:m = matchlist(l:line, '\V\^\(\.\*\):\(\[0-9]\+\): \(\.\*\)')
    if len(l:m) != 0
      let l:filename = l:m[1]
      let l:line_num = l:m[2]
      let l:title = l:m[3]
      call add(l:matches, {'filename': l:filename, 'lnum': l:line_num, 'text': l:title})
    endif
  endfor

  call setqflist(l:matches)
  execute 'copen'
  execute 'cfirst'
endfunction

command! -nargs=1 CatQF call CatQF(<q-args>)

" =============================================================================

function! OnF11() abort
  execute "ptag " . expand("<cword>")
endfunction

function! LastEditTime() abort
  echo strftime('%c',getftime(expand('%')))
endfunction

command! LastEditTime call LastEditTime()

" =============================================================================
"
function! MyRedir(cmd)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~# '^!'
    let output = system(matchstr(a:cmd, '^!\zs.*'))
  else
    redir => output
    execute a:cmd
    redir END
  endif
  vnew
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, split(output, "\n"))
endfunction

command! -nargs=1 -complete=command MyRedir silent call MyRedir(<q-args>)

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
  let l:stack = []
  for l:i in synstack(line('.'), col('.'))
    call add(l:stack, synIDattr(l:i, 'name') . ', trans: ' . synIDattr(synIDtrans(l:i), 'name'))
  endfor
  echo l:stack
endfunction

command! IdentifySyn call IdentifySyn()

set termguicolors
set cursorline
set background=dark

function! MyHighlights() abort
  let g:LanguageClient_diagnosticsDisplay = {
        \    1: {
        \        "name": "Error",
        \        "texthl": "ALEError",
        \        "signText": "✖",
        \        "signTexthl": "ALEErrorSign",
        \        "virtualTexthl": "LC_Error",
        \    },
        \    2: {
        \        "name": "Warning",
        \        "texthl": "ALEWarning",
        \        "signText": "⚠",
        \        "signTexthl": "ALEWarningSign",
        \        "virtualTexthl": "LC_Warning",
        \    },
        \    3: {
        \        "name": "Information",
        \        "texthl": "ALEInfo",
        \        "signText": "ℹ",
        \        "signTexthl": "ALEInfoSign",
        \        "virtualTexthl": "LC_Info",
        \    },
        \    4: {
        \        "name": "Hint",
        \        "texthl": "ALEInfo",
        \        "signText": "➤",
        \        "signTexthl": "ALEInfoSign",
        \        "virtualTexthl": "LC_Hint",
        \    },
        \}

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

  highlight LC_Error       guibg=#200000 guifg=#600000
  highlight LC_Info        guibg=#002000 guifg=#006000
  highlight LC_Warning     guibg=#202000 guifg=#606000
  highlight LC_Hint        guibg=#200020 guifg=#600060
  highlight ALEError       guibg=#770000 guifg=#ffffff
  highlight ALEErrorSign   guibg=#770000 guifg=#ff0000
  highlight ALEInfo        guibg=#774400 guifg=#ffffff
  highlight ALEInfoSign    guibg=#774400 guifg=#ff8800
  highlight ALEWarning     guibg=#777700 guifg=#ffffff
  highlight ALEWarningSign guibg=#777700 guifg=#ffff00
  highlight ALEVirtualTextError         guibg=#200000 guifg=#600000
  highlight ALEVirtualTextInfo          guibg=#002000 guifg=#006000
  highlight ALEVirtualTextWarning       guibg=#202000 guifg=#606000
  highlight ALEVirtualTextStyleError    guibg=#200000 guifg=#600000
  highlight ALEVirtualTextStyleWarning  guibg=#202000 guifg=#606000

  highlight ExtraWhitespace ctermbg=red guibg=red

  highlight clear CursorLine
  highlight CursorLineNR   guifg=#dddddd guibg=#222222
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
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_follow_anchor = 1

" This 'Compose' mode enables automatic reparagraphing, that is also properly
" sensitive to bullet lists. However it needs to be enabled explicitly
" otherwise it would mess other aspects of markdown syntax such as titles
" and code.

function! MyMarkdownToggleComposeModeDisable()
  set textwidth&
  set formatoptions-=a
  set formatoptions-=n
  let b:myvim_markdown_compose_mode = 0
endfunction

function! MyMarkdownToggleComposeModeEnable()
  " Limit line endings, so that we get nice readable ASCII
  setl textwidth=80

  " Autoformat for end-of-line wrap
  setl formatoptions+=a

  " Don't mess with bullet lists, and not even ones arranged in a tree with
  " indentation.
  setl formatoptions+=n
  let b:myvim_markdown_compose_mode = 1
endfunction

function! MyMarkdownToggleComposeMode()
  if !get(b:, 'myvim_markdown_compose_mode', 0)
    call MyMarkdownToggleComposeModeEnable()
    echom 'vim-markdown: compose mode enabled'
  else
    call MyMarkdownToggleComposeModeDisable()
    echom 'vim-markdown: compose mode disabled'
  endif
endfunction

function! MyMarkdownSetComposeMode(mode)
  let b:myvim_markdown_compose_mode = a:mode
  if b:myvim_markdown_compose_mode == 1
    call MyMarkdownToggleComposeModeEnable()
  else
    call MyMarkdownToggleComposeModeDisable()
  endif
endfunction

function! MyMarkdownFindPreviousBulletIndent()

endfunction

function! MyMarkdownInsertBullet()
  let l:mode = get(b:, 'myvim_markdown_compose_mode', 0)
  call MyMarkdownSetComposeMode(0)
  let l:prefix = repeat(' ', (indent('.') / &shiftwidth) * &shiftwidth)
  call append('.', l:prefix.'* ')
  keepjumps normal! j$
  startinsert
  keepjumps normal! l
  call MyMarkdownSetComposeMode(l:mode)
  startinsert!
endfunction

function! MyMarkdownInsertSubBullet()
  let l:mode = get(b:, 'myvim_markdown_compose_mode', 0)
  call MyMarkdownSetComposeMode(0)
  let l:prefix = repeat(' ', (1 + (indent('.') / &shiftwidth)) * &shiftwidth)
  call append('.', l:prefix.'* ')
  keepjumps normal! j$
  startinsert
  keepjumps normal! l
  call MyMarkdownSetComposeMode(l:mode)
  startinsert!
endfunction

function! MyMarkdownGQ()
  let l:mode = get(b:, 'myvim_markdown_compose_mode', 0)
  call MyMarkdownSetComposeMode(0)
  keepjumps normal! gvgq
  call MyMarkdownSetComposeMode(l:mode)
endfunction

function! MyMarkdownCodeBlockSelection() range
  let l:mode = get(b:, 'myvim_markdown_compose_mode', 0)
  call MyMarkdownSetComposeMode(0)

  let [l:line_start] = getpos("'<")[1:1]
  let [l:line_end] = getpos("'>")[1:1]

  call append(l:line_start-1, "```")
  call append(l:line_end + 1, "```")
  call MyMarkdownSetComposeMode(l:mode)

  call setpos('.', [0, l:line_start, 4, 0])
endfunction

function! MyMarkdownSettings()
  setlocal spell
  let b:Markdown_LinkFilter = function('expand')
  noremap <buffer> <A-e>d  Go<CR><CR><C-R>=MyVimEditInsertDateLine()<CR><CR>
  map <buffer> <leader>e\ <A-e>d
  noremap <buffer> <silent> gq :call MyMarkdownGQ()<CR>
  imap <buffer> <A-e>d  <C-c><A-e>d

  noremap <buffer> <silent> <A-e><CR>      :call MyMarkdownInsertBullet()<CR>
  noremap <buffer> <silent> <C-CR>         :call MyMarkdownInsertBullet()<CR>
  noremap <buffer> <silent> <leader><Down> :call MyMarkdownInsertBullet()<CR>

  noremap <buffer> <silent> <A-e><Right> :call MyMarkdownInsertSubBullet()<CR>
  noremap <buffer> <silent> <leader><Right> :call MyMarkdownInsertSubBullet()<CR>
  map <buffer> <CR> <Plug>Markdown_OpenAnyUnderCursor()
  noremap <buffer> <C-del> :call MyMarkdownToggleComposeMode()<CR>
  inoremap <buffer> <C-del> <C-c>:call MyMarkdownToggleComposeMode()<CR>
  vnoremap <buffer> <silent> <leader>` :call MyMarkdownCodeBlockSelection()<CR>

  call MyMarkdownToggleComposeModeDisable()
  Indent4Spaces
  setl formatlistpat+=\\\|^\\s*\\*\\s*
  setl comments=fb:>,fb:*,fb:+,fb:-
  setl formatoptions-=q

  syntax sync fromstart
endfunction

function! MyMarkdownBulletInsertion()
  if get(b:, 'myvim_markdown_compose_mode', 0)
    setl formatoptions-=a
  endif
  let l:prefix = repeat(' ', (indent('.') / &shiftwidth) * &shiftwidth)
  call append('.', l:prefix.'* ')
  keepjumps normal! j$
  startinsert
  keepjumps normal! l
  if get(b:, 'myvim_markdown_compose_mode', 0)
    setl formatoptions+=a
  endif
endfunction

augroup MarkdownEditSettings
  autocmd!

  autocmd FileType markdown call MyMarkdownSettings()
augroup END

function! MyMailSettings()
  setlocal spell
endfunction

augroup MailEditSettings
  autocmd!

  autocmd FileType mail call MyMailSettings()
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
  setlocal shiftwidth=2 expandtab
  nnoremap <buffer> <C-e> :call VimEvalLine()<CR>
  vnoremap <buffer> <C-e> :call VimEvalSelected()<CR>
endfunction

augroup VimEditSettings
  autocmd!
  autocmd Filetype vim call MyVimEditSettings()
augroup END

function! MyVimEditInsertDateLine() abort
  return strftime("# At %Y-%m-%d %H:%M:%S\n")
endfunction

function! MyVimEditInsertDateLineWithTags() abort
  call append(line('$'), [
      \ "",
      \ "",
      \ substitute(MyVimEditInsertDateLine(), '\n', '', ''),
      \ "",
      \ "Tags: "
      \ ])
  call setpos('.', [0, line("#") + 4])
  exec "normal! G\<End>"
  startinsert
  exec "normal! \<Right>"
endfunction


" =============================================================================
" Rust

function! EditNearestCargo() abort
  exec "edit ".cargo#nearestCargo(0)
endfunction

augroup RustEditSettings
  autocmd!
  autocmd FileType rust nnoremap <buffer> <leader>qc :call EditNearestCargo()<CR>
  autocmd FileType rust let b:delimitMate_matchpairs = "(:),[:],{:}"
  autocmd FileType rust nnoremap <buffer> > >>
  autocmd FileType rust nnoremap <buffer> < <<
augroup END

" =============================================================================
" Editing helper for languages with {} blocks.
"
" Open curly braces is almost always a block. This adds '{' and the the
" enclosing '}' in the next line and puts the cursor in a new line inside the
" new block. This also takes care going to the end of the line and placing
" a space character before '{' if it is missing. It also detects if we are
" inside a string and disables for that scenario.

function! MyInsertBrace() abort
  " Only work if we were at the end of the line
  if col(".") != col("$")
    call feedkeys("{", "n")
    return
  endif

  " Removal of ';' from the end of line if it exists, for extending
  " prototypes.
  let l:line = getline(line('.'))
  if l:line =~ '\V\^\(\.\*\); \*\$'
    let l:m = matchlist(l:line, '\V\^\(\.\*\); \*\$')
    call setline(line('.'), l:m[1])
    echo l:m[1]
    let l:line = l:m[1]
  endif

  " Add a space character before the '{' if needed
  if l:line !~ ' $'
    let l:add_space = "\<Space>"
  else
    let l:add_space = ''
  endif

  call feedkeys(l:add_space."{\<CR>}\<Up>\<End>\<CR>", "n")
endfunction

augroup CurlyLanguages
  autocmd!
  autocmd FileType rust\|c\|cpp inoremap <silent> <buffer>
      \ { <C-\><C-O>:call MyInsertBrace()<CR>

  " Fallback to regular { in case we need it, with <A-[>
  autocmd FileType rust\|c\|cpp inoremap <silent> <buffer>
      \ <A-[> {
augroup END


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
let g:rooter_silent_chdir = 1

" =============================================================================
" Git-related stuff

let g:conflict_marker_enable_mappings = 0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_sign_allow_clobber = 1

augroup MyGitGutterAutoCmds
  autocmd!
  autocmd BufWritePost * GitGutter
augroup END

set updatetime=400

function! MySplitGitMode(command) abort
  let l:path = FugitiveExtractGitDir(expand('%:p'))
  vertical botright new
  call FugitiveDetect(l:path)
  execute a:command
  wincmd p
endfunction

function! MyGitShowHead() abort
  call MySplitGitMode("Gedit @")
endfunction

command! SplitGitHEAD call MyGitShowHead()


let s:my_fzf_git_diff_hunk_program = expand('<sfile>:p:h')."/bin/fzf-git-diff-hunk-preview"

function! MyFZFDiffHunks(cmd,...) abort
  let l:screen = get(a:, 1, 'half')
  let l:matches = []
  let l:filename = ''
  let l:filename_color = "\x1b[38;2;155;255;155m"
  let l:white = "\x1b[38;2;255;255;255m"
  let l:lnum_color = "\x1b[38;2;77;127;77m"
  let l:grey = "\x1b[38;2;255;255;155m"

  let l:hunknum = 1
  for l:line in systemlist("git diff " . a:cmd . " | grep -E '^(diff|@@)'")
    let l:m = matchlist(l:line, '\V\^diff --git a/\(\.\*\) b/\(\.\*\)')
    if len(l:m) != 0
      let l:filename = l:m[2]
      let l:hunknum = 1
      continue
    endif
    let l:m = matchlist(l:line, '\V\^@@ -\[^ ]\+ +\(\[0-9]\+\)\[ ,]\[^@]\*@@\(\.\*\)')
    if len(l:m) != 0
      let l:line_num = l:m[1]
      let l:title = l:m[2]
      call add(l:matches,
            \ printf("%3d " . l:filename_color . "%s"
            \ . l:white. ":" . l:lnum_color. "%d"
            \ . l:white. " %s",
            \ l:hunknum,
            \ l:filename,
            \ l:line_num,
            \ l:title))
    endif
    let l:hunknum += 1
  endfor

  if len(l:matches) == 0
    if l:screen == 'full'
      execute "normal! :x\<CR>"
    endif
    return
  endif

  let l:options = [
      \"--ansi", "-e", "--no-sort", "--tac",
      \"--preview-window", "down:70%:noborder",
      \"--preview", s:my_fzf_git_diff_hunk_program." '".a:cmd."' {}"
      \]

  if l:screen == 'full'
    let l:down = "100%"
  else
    let l:down = "50%"
  endif

  let l:opts = {}
  function! l:opts.sink(single)
    if len(a:single) == 1
      let l:m = matchlist(a:single[0], '\V\^ \*\(\[0-9]\*\) \(\[^:]\*\):\(\[0-9]\*\)')
      if len(l:m) != 0
        execute "edit" l:m[2]
        call setpos(".", [0, str2nr(l:m[3]), 0, 0])
      endif
    endif
  endfunction

  let l:v = fzf#run(fzf#wrap({
              \ 'source': l:matches,
              \ 'down': l:down,
              \ 'sink*': remove(opts, 'sink'),
              \ 'options': l:options,
              \ }))
endfunction

function! MyGitCheckoutHeadDiffHunk() abort
  let l:diff_command = 'git diff HEAD~1 -U0 -R'
  let l:lines = line('.') . '-' . line('.')
  let l:filterdiff_command = 'filterdiff -i b/'.expand('%').' --lines='.l:lines
  let l:command = l:diff_command . ' | ' . l:filterdiff_command . ' | patch -p1'
  silent call system(l:command)
  normal! :edit<CR>
endfunction

function! MyGitCommitHook() abort
  setlocal spell

  " Override 'h' shortcut to show what we are commiting
  nnoremap <buffer> <C-g>h :call MyGitShowHead()<CR>

  " Quick save commit message and return
  nnoremap <buffer> <C-g><CR> :w \| bd<CR>
  nnoremap <buffer> <M-PageUp> :w \| bd<CR>
  imap <buffer> <C-g><CR> <C-c><C-g><CR>
  imap <buffer> <M-PageUp> <C-c><C-g><CR>

  startinsert
endfunction

function! SplitGitCherryPick() abort
  let content = readfile('.git/CHERRY_PICK_HEAD')
  call MySplitGitMode('Gedit ' . content[0])
endfunction

function! MyCommitMessageEndHook() abort
  if &filetype ==# 'gitcommit'
    silent GitGutterAll
  endif
endfunction

function! MyGitUnstageCurrentFile() abort
  silent execute '!git reset HEAD '.expand('%')
  GitGutter
endfunction

augroup GitCommitAutocmds
  autocmd!
  autocmd! FileType gitcommit call MyGitCommitHook()
  autocmd! BufDelete,BufWipeout * call MyCommitMessageEndHook()
augroup END

function! MyGitResetBufferToLastCommitChanges()
  execute ':silent !git reset HEAD~1 --' expand('%')
  e
endfunction

function! MyGitAntiCommitAndUnstage() abort
  execute ':silent !git reset --soft HEAD~1'
  execute ':silent !git reset'
  silent GitGutterAll
  let a:current = system('git --no-pager log -1 --oneline')
  echom 'HEAD commit rewinded back, pointing to '.a:current
endfunction

function! MyGitCommitAll() abort
  Gcommit -a
endfunction

function! MyGitCommit() abort
  Gcommit
endfunction

function! MyGitAddAllAmend() abort
  Gcommit -a --amend
endfunction

" Based on stuff from https://github.com/junegunn/fzf.vim/issues/603:
function! s:open_branch_fzf(line)
  let l:parser = split(a:line)
  let l:branch = l:parser[0]
  if l:branch ==? '*'
    let l:branch = l:parser[1]
  endif
  silent execute '!git checkout ' . l:branch
endfunction

command! -bang -nargs=0 GCheckout
  \ call fzf#vim#grep(
  \   'git branch -v', 0,
  \   {
  \     'sink': function('s:open_branch_fzf')
  \   },
  \   <bang>0
  \ )

function! s:my_gitfiles_head(line)
  silent execute 'edit ' . a:line
endfunction

command! -bang -nargs=0 GFilesHead
  \ call fzf#vim#grep(
  \   "git show HEAD --name-status --pretty='' | cut -f2", 0,
  \   {
  \     'sink': function('s:my_gitfiles_head')
  \   },
  \   <bang>0
  \ )

function! s:rebase_interactive_sink(single_item)
  if len(a:single_item) == 2
    let l:items = split(a:single_item[1], " ")
    execute "Grebase" l:items[1] "--interactive"
  endif
endfunction

function! MyFZFChooseRebaseInteractive()
  call fzf#vim#commits({
  \  'sink*': function('s:rebase_interactive_sink'),
  \})
endfunction

" FZF shortcuts
nnoremap <C-g><C-f> :GFiles<CR>
nnoremap <C-g>f     :GFiles<CR>
nnoremap <C-g>d     :call MyFZFDiffHunks('')<CR>
nnoremap <C-g><C-d> :call MyFZFDiffHunks('')<CR>
nnoremap <C-g>D     :call MyFZFDiffHunks('HEAD')<CR>
nnoremap <C-g>C     :call MyFZFDiffHunks('--cached')<CR>
nnoremap <C-g>j     :call MyFZFDiffHunks('HEAD~1')<CR>
nnoremap <C-g><C-j> :call MyFZFDiffHunks('HEAD~1')<CR>
nnoremap <C-g>h     :silent GFilesHead<CR>
nnoremap <C-g><C-h> :silent GFilesHead<CR>
nnoremap <C-g><C-e> :GFiles?<CR>
nnoremap <C-g>e     :GFiles?<CR>
nnoremap <C-g><C-l> :Commits<CR>
nnoremap <C-g>l     :Commits<CR>
nnoremap <C-g><C-o> :SplitGitHEAD<CR>
nnoremap <C-g>o     :SplitGitHEAD<CR>
nnoremap <C-g>L     :BCommits<CR>
nnoremap <C-g>i     :call MyFZFChooseRebaseInteractive()<CR>
nnoremap <C-g><cr>  :Magit<CR>
nnoremap <C-g><C-CR>  :Magit<CR>
nnoremap <C-g><C-c> :GCheckout<CR>
nnoremap <C-g>c     :GCheckout<CR>
nnoremap <C-g>a     :call MyGitCommitAll()<CR>
nnoremap <C-g>y     :call MyGitCommit()<CR>
nnoremap <C-g>p     :call SplitGitCherryPick()<CR>

nmap     <C-g><C-r> <C-g>r
nnoremap <C-g>r     :call MyGitUnstageCurrentFile()<CR>

nnoremap <C-g>k     :call MyGitAntiCommitAndUnstage()<CR>
nnoremap <C-g>AA    :call MyGitAddAllAmend()<CR>
nnoremap <C-g>PP    :Gpush<CR>
nnoremap <C-g>1r    :call MyGitResetBufferToLastCommitChanges()<CR>

nmap     <C-g>b         <Plug>(conflict-marker-next-hunk)
nmap     <C-g>t         <Plug>(conflict-marker-prev-hunk)
nnoremap <C-g>Q         :call EditConflictFiles()<CR>
nmap     <C-g>q<Delete> <Plug>(conflict-marker-none)
nmap     <C-g>q<Down>   <Plug>(conflict-marker-themselves)
nmap     <C-g>q<Up>     <Plug>(conflict-marker-ourselves)
nmap     <C-g>q<CR>     <Plug>(conflict-marker-both)

nnoremap <C-g>x         :Gina status -s<CR>

" Other shortcuts
nmap     <leader>gj     :call gv#diff('HEAD~1')<CR>
nmap     <leader>gD     :call gv#diff('HEAD')<CR>
nmap     <leader>gd     :call gv#diff()<CR>
nmap     <leader>gC     :call gv#diff('--cached')<CR>
nmap     <leader>gi     :call MyFZFChooseRebaseInteractive()<CR>

" Taking care of hunks
nnoremap <C-g><Delete>  :GitGutterUndoHunk<CR>:w<CR>
nmap     <C-g><Down>    <Plug>GitGutterNextHunk
imap     <C-g><Down>    <C-c><Plug>GitGutterNextHunk
nmap     <C-g><Up>      <Plug>GitGutterPrevHunk
imap     <C-g><Up>      <C-c><Plug>GitGutterPrevHunk
nmap     <C-g><Backspace> :call MyGitCheckoutHeadDiffHunk()<CR>
nmap     <C-g><Insert>  <Plug>GitGutterStageHunk
imap     <C-g><Insert>  <C-c><Plug>GitGutterStageHunk
inoremap <C-g><Delete>  <C-c>:GitGutterUndoHunk<CR>:w<CR>

" Retain previous functionality via <leader>
nnoremap <leader><C-g> <C-g>

" Show the commit we are attempting to cherry-pick.
nmap <leader>gp :call SplitGitCherryPick()<CR>
nmap <leader>gb :Gina branch<CR>
nmap <leader>gl :!git log
nmap <leader>gh :SplitGitHEAD<CR>
nmap <leader>grb- :!git rebase<CR>
nmap <leader>grbi :!git rebase -i<CR>

nmap <leader>hu :GitGutterUndoHunk<CR>

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
" FZF
"
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fs :GFiles?<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>ft :BTags<CR>
nnoremap <leader>fL :Lines<CR>
nnoremap <leader>fT :Tags<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fM :Maps<CR>
nnoremap <leader>fw :Windows<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>f: :History:<CR>
nnoremap <leader>:  :History:<CR>
nnoremap <leader>f/ :History/<CR>
nnoremap <leader>/  :History/<CR>
nnoremap <leader>f? :Helptags<CR>
nnoremap <leader>?  :Helptags<CR>
nnoremap <leader>fc :BCommits<CR>
nnoremap <leader>fC :Commits<CR>
nnoremap <leader>fv :Commands<CR>

function! MyGitRoot() abort
  let l:dir = systemlist('git rev-parse --show-toplevel')
  if len(l:dir) != 0
    return l:dir[0]
  endif
  let l:dir = systemlist('git rev-parse --git-dir')
  if len(l:dir) != 0
     return fnamemodify(l:dir[0], ":p:h:h")
  else
endfunction

function! MyGitGrep(arg) abort
  let s:string = shellescape(a:arg)
  let l:recursive = ""
  if get(g:, 'gg_recursive', 1)
     let l:recursive = "--recurse-submodules"
  endif
  call fzf#vim#grep('git grep '.l:recursive.' --line-number --color '.s:string.' 2>/dev/null', 0,
      \ { 'dir': MyGitRoot() },
      \ 0)
  call histadd(':', 'Gg '.a:arg)
endfunction

function! MyGitGrepToggleRecursive() abort
  if get(g:, 'gg_recursive', 1)
    let g:gg_recursive = 0
    echom "GitGrep: Non recursive by default"
  else
    let g:gg_recursive = 1
    echom "GitGrep: Recursive by default"
  endif
endfunction

command! -nargs=+ Gg call MyGitGrep(<q-args>)
command! GgToggleRecursive call MyGitGrepToggleRecursive()

nnoremap <F9> :Gg <c-r>=expand("<cword>")<CR><CR>
nnoremap <C-F9> :Gg <c-r>=""<CR>
nnoremap <tab><F9> :Rg <c-r>=expand("<cword>")<CR><CR>
nnoremap <tab><C-F9> :Rg <c-r>=""<CR>

" =============================================================================
" Emacs migration path:

nnoremap <C-z> :undo<CR>
inoremap <C-z> <ESC>:undo<CR>i
nnoremap <silent> <C-x>f :FZF<CR>
nnoremap <silent> <C-x><C-f> :FZF<CR>
nmap <Esc>x <Nop>

" Saving or quiting from anywhere
noremap  <C-x>s     <C-c>:w<CR>
noremap  <C-x><C-s> <C-c>:w<CR>
noremap! <C-x>s     <C-c>:w<CR>
noremap! <C-x><C-s> <C-c>:w<CR>
inoremap <C-x>s     <C-c>:w<CR><right>i
inoremap <C-x><C-s> <C-c>:w<CR><right>i
noremap  <C-x>q     <C-c>:q<CR>
noremap  <C-x><C-q> <C-c>:q<CR>
noremap! <C-x>q     <C-c>:q<CR>
noremap! <C-x><C-q> <C-c>:q<CR>
noremap  <C-x>x     <C-c>:x \| bd<CR>
noremap  <C-x><C-x> <C-c>:x \| bd<CR>
noremap! <C-x>x     <C-c>:x \| bd<CR>
noremap! <C-x><C-x> <C-c>:x \| bd<CR>

" =============================================================================

command! HomeRegenTags :helptags ~/.vim_runtime/doc

" =============================================================================
" Language server

let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ }
let g:LanguageClient_autoStart = 0

nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
noremap <leader>r<CR> :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>k :call LanguageClient#textDocument_hover()<CR>
noremap <leader>rc :call LanguageClient#textDocument_rename(
      \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>
" Rename - rs => rename snake_case
noremap <leader>rs :call LanguageClient#textDocument_rename(
      \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
" Rename - ru => rename UPPERCASE
noremap <leader>ru :call LanguageClient#textDocument_rename(
      \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>

" =============================================================================

if get(g:, 'my_rust_use_LC', v:false)
    let g:ale_linters.rust = []
    let g:LanguageClient_autoStart = 1
endif

" =============================================================================
" Config for vim-highlightedyank

let g:highlightedyank_highlight_duration = 200

hi HighlightedyankRegion guibg=#008080 gui=NONE term=NONE
hi SpellBad guibg=#500000 gui=underline term=underline

" =============================================================================
" Misc

function! MyVimLeave() abort
  if has('nvim')
    if get(g:, 'vim_leave_sahda', 0)
      wshada
    endif
  endif
endfunction

augroup MyVimLeaveAutoGroup
  " force write shada on leaving nvim
  autocmd VimLeave * call MyVimLeave()
augroup END

let g:qf_auto_resize = 0
let g:qf_window_bottom = 0
let g:qf_mapping_ack_style = 1

noremap <silent> <F8>   :Explore<CR>
noremap <silent> <S-F8> :sp +Explore<CR>

" Look for a man page
map <C-F1> <Plug>(Man)

" Reload current file
nnoremap <silent> <leader>t :e<CR>

" Force-reload current file (losing changes!)
nnoremap <silent> <leader>!t :e!<CR>

" =============================================================================
" File is not checked-in on purpose, it is for experimental per-environment overrides.

if filereadable(expand("~/.vim_runtime/project-specific.vim"))
  " examples:
  " call lh#local_vimrc#munge('whitelist', $HOME.'<some-path>')
  " map <leader><tab>m :tabedit <some-path><CR>
  runtime project-specific.vim
endif

" Goodbye!
" =============================================================================
