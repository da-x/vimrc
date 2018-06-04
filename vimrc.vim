"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Welcome!

" Some bits are taken from: https://github.com/amix/vimrc
" Others from https://github.com/jonhoo/configs/blob/master/.vimrc

set nocompatible
set shell=/bin/bash

" Prevent Ctrl-S terminal suspend function
silent exec "!stty -ixon"

" =============================================================================
" # PLUGINS
" =============================================================================

filetype off
call plug#begin('~/.vim_runtime/vim-plugged')

" Libs
Plug 'LucHermitte/lh-vim-lib'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'vim-scripts/tlib'
Plug 'roxma/vim-hug-neovim-rpc'

" Settings
Plug 'da-x/local_vimrc'
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
Plug 'junegunn/gv.vim'
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

" Language related
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

" Other
Plug 'junegunn/vader.vim'
Plug 'Shougo/echodoc.vim'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal fixups

" Various missing ansi code mappings.
" The ANSI codes for Shift-Enter were specially invented.
map <Char-0x0c> :call OnF11()<cr>
map <Char-0x1c> :call CtrlBar()<cr>
map <Char-0x1f> :call CtrlMinus()<cr>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make keystores the most predictable being time-independent:
set notimeout
set nottimeout


" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au CursorHold * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
map <Space> <leader>
set showcmd

" Fast saving
nmap <leader>w :w!<cr>

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set autoindent
set backspace=eol,start,indent
set cindent
set cinoptions=:0,l1,t0,g0,(0
set cmdheight=2
set completeopt-=preview
set encoding=utf8
set ffs=unix,dos,mac
set foldcolumn=1
set hidden
set history=500
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set magic
set mat=2
set nobackup
set noequalalways
set noerrorbells
set noexpandtab
set nofoldenable
set noignorecase
set noshowmode
set nostartofline
set noswapfile
set novisualbell
set nowb
set number
set ruler
set scrolloff=3
set shiftwidth=4
set shortmess+=atc
set showmatch
set showtabline=2
set smartcase
set smartindent
set smarttab
set softtabstop=8
set splitbelow
set splitright
set switchbuf=useopen
set t_vb=
set tabstop=8
set tm=500
set undodir=~/.vim_runtime/.temp_dirs/undodir
set undofile
set updatetime=500
set whichwrap+=<,>,h,l
set wrap

set tags=._TAGS_,./rusty-tags.vi;/

" Disable ex mode
map q: <Nop>
nnoremap Q <nop>

" Shortcuts

nnoremap Q @q
nnoremap ; :
nnoremap <leader><leader> <c-^>
noremap <leader>_ ct_
noremap <leader>- ct-
noremap <leader>' ct'
noremap <leader>" ct"
noremap <leader>, ct,
noremap <leader>; ct;
map <leader>i] ysiw]
map <leader>i- ysiw-
map <leader>i' ysiw'
map <leader>i" ysiw"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

if !has('nvim')
    set term=xterm-256color
endif

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode related

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

map <C-t><Insert> :tabnew<cr>
map! <C-t><Insert> <C-c><C-t><Insert>
map <C-t><Delete> :tabclose<cr>
map! <C-t><Delete> <C-c><C-t><Delete>
map <C-t><Left> :-tabmove<cr>
map! <C-t><Left> <C-c><C-t><Left>
map <C-t><Right> :+tabmove<cr>
map! <C-t><Right> <C-c><C-t><Right>
map <C-t><Home> :0tabmove<cr>
map! <C-t><Home> <C-c><C-t><Home>
map <C-t><End> :tabmove<cr>
map! <C-t><End> <C-c><C-t><End>
map <C-t>1 :1tabnext<cr>
map <C-t>2 :2tabnext<cr>
map <C-t>3 :3tabnext<cr>
map <C-t>4 :4tabnext<cr>
map <C-t>5 :5tabnext<cr>
map <C-t>6 :6tabnext<cr>
map <C-t>7 :7tabnext<cr>
map <C-t>8 :8tabnext<cr>
map <C-t>9 :9tabnext<cr>
map! <C-t>1 :1tabnext<cr>
map! <C-t>2 :2tabnext<cr>
map! <C-t>3 :3tabnext<cr>
map! <C-t>4 :4tabnext<cr>
map! <C-t>5 :5tabnext<cr>
map! <C-t>6 :6tabnext<cr>
map! <C-t>7 :7tabnext<cr>
map! <C-t>8 :8tabnext<cr>
map! <C-t>9 :9tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
nmap <C-t><Cr> <leader>tl

augroup DotfilesBasicTabLeave
  au!
  au TabLeave * let g:lasttab = tabpagenr()
augroup END

map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
augroup DotfilesBasicLastEdit
  au!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings

" Allow cursor to go after one last character of the line, like in
" modern editing environments.
set virtualedit=onemore,block

" Make <End> really go to the end of line (but only in normal mode),
" because in visual mode we already have it.
nnoremap <expr> <End> (col('$') > 1 ? "<end><right>":'')

" 'u' and 'U' should not change case in visual mode as 'u' already
" does entirely different thing in normal mode. Make them consistent,
" and rebind these actions to be under the leader prefix. They are
" rare enough as it is.
vnoremap <leader>u u
vnoremap <leader>U U
vnoremap u <C-c>u
vnoremap U <C-c>U

" Remap VIM 0 to first non-blank character
map 0 ^

" Move lines and selections
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell checking

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-q> <Plug>snipMateNextOrTrigger
smap <C-q> <Plug>snipMateNextOrTrigger
imap <C-j> <Plug>snipMateNextOrTrigger
smap <C-j> <Plug>snipMateNextOrTrigger
map <leader>sm :SnipMateOpenSnippetFiles<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commentary

xmap <C-r> gc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=35
let NERDTreeShowHidden=0
let NERDTreeQuitOnOpen=1

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" surround.vim config

" Annotate strings with gettext http://amix.dk/blog/post/19678

vmap Si S(i_<esc>f)
vmap ( S)
vmap [ S]
vmap { S{

au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline

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

autocmd User ALELint call lightline#update()
autocmd BufRead *.orig setlocal readonly

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE (syntax checker)

let g:ale_rust_cargo_use_check = 0
let g:ale_change_sign_column_error = 1
let g:ale_set_highlights = 1
let g:ale_linters = {}
let g:ale_set_balloons = 1
let g:ale_linters.c = ['pac']
let g:ale_linters.cpp = ['pac']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config for auto-pairs

let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsCenterLine = ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast editing and reloading of vimrc configs

map <leader>eR :source ~/.vimrc<cr>
map <leader>ea :e! ~/.config/alacritty/alacritty.yml<cr>
map <leader>ee :e! ~/.vim_runtime/vimrc.vim<cr>
map <leader>eg :e! ~/.files/gitconfig<cr>
map <leader>et :e! ~/.tmux.conf<cr>
map <leader>ex :e! ~/.Xdefaults<cr>
map <leader>ez :e! ~/.zsh/zshrc.sh<cr>
map <leader>e_ :e! ~/.vim_runtime/project-specific.vim<cr>
map <leader>ed :e! .git/todo.md<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash like keys for the command line
cnoremap <C-A>	<Home>
cnoremap <C-E>	<End>
cnoremap <C-K>	<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis/bracket
vnoremap <A-1> <esc>`>a)<esc>`<i(<esc>
vnoremap <A-2> <esc>`>a]<esc>`<i[<esc>
vnoremap <A-3> <esc>`>a}<esc>`<i{<esc>
vnoremap <A-4> <esc>`>a"<esc>`<i"<esc>
vnoremap <A-q> <esc>`>a'<esc>`<i'<esc>
vnoremap <A-e> <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap <A-1> ()<esc>i
inoremap <A-2> []<esc>i
inoremap <A-3> {}<esc>i
inoremap <A-4> {<esc>o}<esc>O
inoremap <A-q> ''<esc>i
inoremap <A-d> ""<esc>i

" Map auto complete of (, ", ', [
nnoremap <A-1> i()<esc>i
nnoremap <A-2> i[]<esc>i
nnoremap <A-3> i{}<esc>i
nnoremap <A-4> i{<esc>o}<esc>O
nnoremap <A-q> i''<esc>i
nnoremap <A-d> i""<esc>i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windowing-related

map <tab> <c-w>
map <tab><tab> <c-w><c-w>
map <tab>\ <c-w>v
map <tab>- <c-w>s

" Thanks https://github.com/assaflavie

nnoremap <silent> -        :resize -2<CR>
nnoremap <silent> =        :resize +2<CR>
nnoremap <silent> <Bar>    :vert resize +2<CR>
nnoremap <silent> <Bslash> :vert resize -2<CR>

function! CtrlBar()
  exec "vsplit"
endfunction

function! CtrlMinus()
  exec "split"
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Give indication in which mode we are at, using a cursor shape

augroup cursorShape
  " This is on Autocmds because for some reason vim-gnupg reverts to the
  " original behavior.
  autocmd!
  au BufEnter * let &t_SI = "\<Esc>[6 q"
  au BufEnter * let &t_SR = "\<Esc>[4 q"
  au BufEnter * let &t_EI = "\<Esc>[2 q"
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement

" Faster moving of the cursor using Ctrl and arrows
nnoremap <silent> <C-Up>   {
nnoremap <silent> <C-Down> }
inoremap <silent> <C-Up>   <C-c>{i
inoremap <silent> <C-Down> <C-c>}i
vnoremap <silent> <C-Up>   {
vnoremap <silent> <C-Down> }

" Got used to this from other environments (go to start of file / end of file)
nmap <silent> <c-home> 1G
nmap <silent> <c-end>  G

" When navigating on line wraps with arrows, be more visual about it
nmap <Down> gj
nmap <Up>   gk

" Arrows are special and break out of operator-pending mode. Can still use
" hjkl in operator mode.
omap <Down>  <esc><Down>
omap <Up>    <esc><Up>
omap <Right> <esc><Right>
omap <Left>  <esc><Left>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing

" Moving text around, adjusting for indentation.
" Extremely handy when re-ordering code manually.
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" Limit idle time in insert mode
augroup myPreventInsertModeStalling
  autocmd!
  au CursorHoldI * stopinsert
  au InsertEnter * let updaterestore=&updatetime | set updatetime=60000
  au InsertLeave * let &updatetime=updaterestore
augroup END

" Split lines
nnoremap <C-k> i<CR><Esc>

" Make Backspace behave like it normally does, in normal mode
nnoremap <BS> "_X

" Search replace the highlight marking, either in the entire buffer or in the
" currently selected region in visual mode.
nnoremap <A-h> :%s///g<left><left>
vnoremap <A-h> :s///g<left><left>

function! InsertSelectionText()
  let l:search_mark = @/
  let l:n = strlen(l:search_mark)
  echom strpart(l:search_mark, 0, 1)
  echom strpart(l:search_mark, l:n - 1, 1)
  if strpart(l:search_mark, 0, 2) ==# "\\<" && strpart(l:search_mark, l:n - 2, 2) ==# "\\>"
     let l:search_mark = strpart(l:search_mark, 2, l:n - 4)
  endif
  return l:search_mark
endfunction

nnoremap <A-r> :%s//<C-r>=InsertSelectionText()<CR>/g<left><left>
vnoremap <A-r> :s//<C-r>=InsertSelectionText()<CR>/g<left><left>
nnoremap <A-w> :%s/<C-r><C-w>/<C-r><C-w>/g<left><left>
vnoremap <A-w> :s/<C-r><C-w>/<C-r><C-w>/g<left><left>

" Add a newline and move down
noremap <silent> <C-J> O<Esc>j

" Exit insert mode (other than <Esc> and <C-c>)
inoremap jK x<C-c>"_x

" Exit insert and keep in the same place (because of virtualedit=onemore)
inoremap <silent> <C-Delete> <C-O>:stopinsert<CR>
map <C-Delete> <Nop>

" Copy a string to the system's clipbard
function! SetSystemClipboard(string)
  let l:display = expand("$DISPLAY")
  if l:display != "" && executable("xsel")
    call system('xsel -i -p', a:string)
    call system('xsel -i -s', a:string)
  endif
endfunction

" Saner yanking and pasting behavior using <A-p> and <C-A-p>:
"
" * When yanking, put the cursor right after the yanked region, whether was
"   yanked in visual mode (lines or not).
" * When pasting, put the cursor either at the beginning of the pasted text or
"   after its end.
"
function! MyAfterYank()
  if @@[strlen(@@) - 1] !=# "\n" || visualmode() ==# 'V'
    " This requires virtualedit=onemore
    execute "normal! l"
  endif
  call SetSystemClipboard(getreg("\""))
endfunction

function! PasteBeforeHack()
  let l:line = getcurpos()[1]
  let l:col = getcurpos()[2]
  execute "normal! P"
  call cursor(l:line, l:col)
endfunction

vnoremap <silent> y y`]:call MyAfterYank()<cr>
noremap <silent> <A-p> :call PasteBeforeHack()<cr>
inoremap <silent> <C-A-p> <C-R>"
inoremap <silent> <A-p> <Nop>
noremap <C-A-p> gP

"Yank various pathnames relating to the current file into the system's clipboard.

function! YankCurrentFilename()
  call SetSystemClipboard(expand("%"))
endfunction

function! YankCurrentDirAbs()
  call SetSystemClipboard(expand("%:p:h"))
endfunction

noremap <silent> <leader>yf :call YankCurrentFilename()<cr>
noremap <silent> <leader>yd :call YankCurrentDirAbs()<cr>

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
function! MoveTextToMarkAndStay(marker) range
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

command! -range -nargs=* Mtmas :<line1>,<line2>call MoveTextToMarkAndStay(<f-args>)

" Operator pending remaps ( http://learnvimscriptthehardway.stevelosh.com/chapters/15.html )
onoremap ( i(
onoremap ' i'
onoremap " i"
onoremap < i<
onoremap [ i[
onoremap { i{
onoremap p( :<c-u>normal! F(vi(<cr>
onoremap p' :<c-u>normal! F'vi'<cr>
onoremap p" :<c-u>normal! F"vi"<cr>
onoremap p< :<c-u>normal! F<vi<<cr>
onoremap p[ :<c-u>normal! F[vi<<cr>
onoremap p{ :<c-u>normal! F{vi{<cr>
onoremap n( :<c-u>normal! f(vi(<cr>
onoremap n' :<c-u>normal! f'vi'<cr>
onoremap n" :<c-u>normal! f"vi"<cr>
onoremap n< :<c-u>normal! f<vi<<cr>
onoremap n[ :<c-u>normal! f[vi<<cr>
onoremap n{ :<c-u>normal! f{vi{<cr>

" Remap Ctrl-D to a single line removal, not affecting the register
map <C-d> "_dd

" Use the delete key without affecting the register
map <Delete> "_x

" Single character insertion
noremap <silent> <A-a> "=nr2char(getchar())<cr>P

imap <S-CR> <cr>

" Save time by using C-^ from insert mode
imap <C-^> <C-c><C-^>

function! SetPerBufferActions()
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

augroup myPerBufferActions
  autocmd!
  autocmd FileType * call SetPerBufferActions()
  autocmd BufNewFile * call SetPerBufferActions()
augroup END

" Insert previous relative buffer filename into the current buffer
let g:previous_buffer_filename = ""
function! LeavePreviousBuffer()
  let g:previous_buffer_filename = expand("%")
endfunction

augroup myRememberPreviousBufferFilename
  autocmd!
  autocmd BufLeave * call LeavePreviousBuffer()
augroup END

function! MyInsertRandom()
  execute "py import vim, random; vim.command('normal i' + str(''.join([random.choice('abcdefghijklmnopqrstuvwxyz') for i in range(10)])))"
  execute "normal! l"
endfunction

function! MyInsertRandomInInsertMode()
  python import random
  return pyeval("''.join([random.choice('abcdefghijklmnopqrstuvwxyz') for i in range(10)])")
endfunction

imap <A-e>f <c-r>=g:previous_buffer_filename<cr>
nmap <A-e>f i<c-r>=g:previous_buffer_filename<cr>
imap <A-e>r  <c-r>=MyInsertRandomInInsertMode()<cr>
map <A-e>r  :call MyInsertRandom()<cr>

" Some settings by file type
function! VimEvalLine()
  execute getline(".")
  echo 'Line evaluated'
  execute "normal! gj"
endfunction

function! MyVimEditSettings()
  setlocal ts=1 sw=2 expandtab
  noremap <buffer> <C-e> :call VimEvalLine()<cr>
endfunction

augroup myVimEditSettings
  autocmd!
  autocmd Filetype vim call MyVimEditSettings()
augroup END

function! MyVimEditInsertDateLine()
  return strftime("#### At %Y-%m-%d %H:%M:%S\n")
endfunction

augroup myMarkdownEditSettings
  autocmd!
  autocmd Filetype markdown map <buffer> <A-e>d  G$<right>i<CR><CR><C-R>=MyVimEditInsertDateLine()<CR><CR>
  autocmd Filetype markdown map <buffer> <leader>e\ <A-e>d
  autocmd Filetype markdown imap <buffer> <A-e>d  <C-R>=MyVimEditInsertDateLine()<CR>
  autocmd Filetype markdown map <buffer> <C-cr> <Plug>Markdown_EditUrlUnderCursor()
augroup END

augroup myHaskellEditSettings
  autocmd!
  autocmd FileType haskell setlocal smartcase
  autocmd Filetype haskell setlocal autoindent
  autocmd Filetype haskell setlocal expandtab
  autocmd Filetype haskell setlocal shiftround
  autocmd Filetype haskell setlocal shiftwidth=4
  autocmd Filetype haskell setlocal smartindent
  autocmd Filetype haskell setlocal smarttab
  autocmd Filetype haskell setlocal softtabstop=4
  autocmd Filetype haskell setlocal tabstop=8
augroup END

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

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

vmap <A-t> *``
imap <A-t> <C-c>*``
nmap <A-t> *``

function! DuplicateLine()
  " And keep in the same column
  let l:prevpos = getcurpos()
  execute "t."
  let l:curpos = getcurpos()
  let l:curpos_prev_col = [l:curpos[0], l:curpos[1], l:prevpos[2], l:curpos[3]]
  call setpos(".", l:curpos_prev_col)
endfunction

nmap <leader>d :call DuplicateLine()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Execute something without the prompt

command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! OnF11()
   execute "ptag " . expand("<cword>")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F10> :Tagbar<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" CInsertIncludeForTag
"
" Search for the filename containing the prototype of the function or
" type definition for a C tag, and insert '#include <filename>' in the
" current file where there is the marker `i`.
"
" if b:insert_include_prefix_remove is defined, and the filename starts
" with this prefix, then it is removed before being inserted as 'filename'.
"

function! CInsertIncludeForTag()
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Invoking completions

" Completion
" tab to select
" and don't hijack my enter key
" inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
" inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

map <C-f> :Files<CR>
inoremap <C-f> <C-x><C-f>
inoremap <C-d> <C-x><C-d>
inoremap <C-l> <C-x><C-l>
inoremap <C-]> <C-x><C-]>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Modern-like selections (moving with shift)

nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
nmap <S-Home> v<Home>
nmap <S-End> v<End>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
vmap <S-End> <End>
vmap <S-Home> <Home>

nmap <C-Space> V
if has('nvim')
  nmap <C-S-PageUp> V
endif
vmap <Cr> y
vmap <C-Cr> *``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Various mappings for function keys
nmap <F2> :Buffers<CR>
map! <F2> <Nop>
imap <F2> <C-c><F2>
nmap <C-F2> :CtrlPMRUFiles<cr>
map! <C-F2> <Nop>
imap <C-F2> <C-c><C-F2>
nmap <F3> :NERDTreeFind<cr>
map! <F3> <Nop>
imap <F3> <C-c><F3>
nmap <C-F3> :NERDTreeToggle<cr>
map! <C-F3> <Nop>
imap <C-F3> <C-c><F3>
nmap <C-S-F3> :CtrlP<cr>
map! <C-S-F3> <Nop>
imap <C-S-F3> <C-c><F3>

" Navigate location lists
nmap <F4> :lnext<cr>
map! <F4> <Nop>
imap <F4> <C-c><F4>
nmap <M-F4> :lprev<cr>
map! <M-F4> <Nop>
imap <M-F4> <C-c><M-F4>
nmap <C-S-F4> :lfirst<cr>
map! <C-S-F4> <Nop>
imap <C-S-F4> <C-c><C-F4>
nmap <C-F4> :lopen<cr>
map! <C-F4> <Nop>
imap <C-F4> <C-c><C-F4>

" Navigate the quickfix list
nmap <F5> :cnext<cr>
map! <F5> <Nop>
imap <F5> <C-c><F5>
nmap <M-F5> :cprev<cr>
map! <M-F5> <Nop>
imap <M-F5> <C-c><M-F5>
nmap <C-F5> :cfirst<cr>
map! <C-F5> <Nop>
imap <C-F5> <C-c><C-F5>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting

" Show highlight names at cursor

func! IdentifySyn(...)
  echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfun

command! IdentifySyn call IdentifySyn()

set termguicolors
set background=dark
colorscheme peaksea-mod

hi cAnsiFunction         guifg=#dddd90   guibg=NONE      gui=NONE
hi cBraces               guifg=#ffdd80   guibg=NONE      gui=NONE
hi cDelimiter            guifg=#ffaa80   guibg=NONE      gui=NONE
hi cNumber               guifg=#ff9999   guibg=NONE      gui=NONE
hi cUserFunction         guifg=#ffcc90   guibg=NONE      gui=NONE

hi IncSearch             guifg=#000000   guibg=#ffff00  gui=bold
hi Search                guifg=#ccffdd   guibg=#006611  gui=bold

hi TabLineFill           guifg=#ffffff   guibg=#000000
hi TabLine               guifg=black     guibg=#222222
hi TabLineSel            guifg=#444444   guibg=#202020   gui=bold

highlight ALEError       guibg=#770000 guifg=#ffffff
highlight ALEErrorSign   guibg=#770000 guifg=#ff0000
highlight ALEInfo        guibg=#774400 guifg=#ffffff
highlight ALEInfoSign    guibg=#774400 guifg=#ff8800
highlight ALEWarning     guibg=#777700 guifg=#ffffff
highlight ALEWarningSign guibg=#777700 guifg=#ffff00

highlight ExtraWhitespace ctermbg=red guibg=red

augroup WhitespaceMatch
  autocmd!

  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END

function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRL P open selection in new tab using <CTRL+ENTER> or <SHIFT+ENTER>

let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<c-x>', '<c-s>'],
      \ 'AcceptSelection("t")': ['<c-t>', '<c-cr>','<s-cr>'],
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown

let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_extensions_in_markdown = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust

let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

au FileType rust nmap <M-,> <Plug>(rust-def)
" au FileType rust EchoDocEnable
" EchoDoc does not support methods well yet.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C

" Our special checker which directs to an external program that intellgently
" picks up on a per-project build system.

let g:syntastic_c_checkers = ['dax']
let g:syntastic_cpp_checkers = ['dax']
let g:linuxsty_patterns = ['_only_used_per_tree']

func! Indent4Spaces(...)
  setlocal expandtab

  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal nosmarttab
endfun

command! Indent4Spaces call Indent4Spaces()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Example: setlocal path=.,subdir/,/usr/include,,"
let g:local_vimrc = ['.git/vimrc_local.vim']

func! LocalVimrc()
  exec ":edit .git/vimrc_local.vim"
endfun

command! -bar LocalVimrc call LocalVimrc()
" File is not checked-in on purpose:

if filereadable(expand("~/.vim_runtime/project-specific.vim"))
" examples:
" call lh#local_vimrc#munge('whitelist', $HOME.'<some-path>')
" map <leader><tab>m :tabedit <some-path><cr>
  source ~/.vim_runtime/project-specific.vim
endif

nmap <leader><tab>s :call lh#local_vimrc#_open_local_vimrc()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sideways.vim

nnoremap <c-x><Left>    :SidewaysLeft<cr>
nnoremap <c-x><Right>   :SidewaysRight<cr>
nnoremap <c-a><Left>    :SidewaysJumpLeft<cr>
nnoremap <c-a><Right>   :SidewaysJumpRight<cr>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-rooter

let g:rooter_patterns = ['.git', '.git/', 'Cargo.toml', 'Makefile']
let g:rooter_change_directory_for_non_project_files = 'current'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Grepper

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nmap <F9> :Grepper -noprompt -cword<cr>
nmap <C-F9> :Grepper -cword<cr>

let g:grepper = {
        \ 'tools': ['git', 'grep'],
        \ 'quickfix' : 1,
        \ 'stop' : 50000,
        \ }

""""""""""""""""""""""""""""""
" CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_mruf_max = 400
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>

" We use c-c instead of c-b because we run under tmux
map <c-c> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git-related stuff

let g:gitgutter_highlight_lines = 0

nmap <leader>hu :GitGutterUndoHunk<cr>
nnoremap <C-h><Delete> :GitGutterUndoHunk<cr>:w<cr>
nmap <C-h><Down> <Plug>GitGutterNextHunk
nmap <C-h><Up> <Plug>GitGutterPrevHunk
inoremap <C-h><Delete> <C-c>:GitGutterUndoHunk<cr>:w<cr>
imap <C-h><Down> <C-c><Plug>GitGutterNextHunk
imap <C-h><Up> <C-c><Plug>GitGutterPrevHunk

func! MyGitRebaseTodoHook(...)
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
endfun

augroup myGitRebaseTodoRebinding
  autocmd!
  autocmd! BufRead git-rebase-todo call MyGitRebaseTodoHook()
augroup END

func! Gamd()
  silent w
  silent exec "Gcommit --amend -a --no-edit"
  echo "File saved, all added and commit amended"
endfun

command! -bar Gamd call Gamd()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emacs migration path:

nnoremap <c-z> :undo<cr>
inoremap <c-z> <ESC>:undo<cr>i
nnoremap <silent> <C-x>f :NERDTreeFind<cr>
nmap <esc>x <Nop>

" Saving or quiting from anywhere

noremap <C-x>s <C-c>:w<cr>
noremap <C-x><C-s> <C-c>:w<cr>
noremap! <C-x>s <C-c>:w<cr>
noremap! <C-x><C-s> <C-c>:w<cr>
noremap <C-x>q <C-c>:q<cr>
noremap <C-x><C-q> <C-c>:q<cr>
noremap! <C-x>q <C-c>:q<cr>
noremap! <C-x><C-q> <C-c>:q<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language server

let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
     \ 'rust': ['rustup', 'run', 'stable', 'rls'],
     \ }

let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config for vim-highlightedyank

let g:highlightedyank_highlight_duration = 200

hi HighlightedyankRegion guibg=#008080 gui=NONE term=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc

let g:qf_auto_resize = 0
let g:qf_window_bottom = 0
let g:qf_mapping_ack_style = 1

map <silent> <F8>   :Explore<CR>
map <silent> <S-F8> :sp +Explore<CR>

" Look for a man page
map <C-F1> <Plug>(Man)

" Search
nmap <C-s> /
nmap <C-S-s> ?

" Goodbye!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
