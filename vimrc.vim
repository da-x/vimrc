""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Welcome!
set nocompatible

" Make keystores the most predictable being time-independent:
set notimeout
set nottimeout

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal fixups

" Prevent Ctrl-S terminal suspend function
silent exec "!stty -ixon"

" Various missing ansi code mappings.
" The ANSI codes for Shift-Enter were specially invented.
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

" Line numbers
set number

" Concise messages
set shortmess+=at

" Sets how many lines of history VIM has to remember
set history=500

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

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Disable ex mode
map q: <Nop>
nnoremap Q <nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo

" Turn backup off, since most stuff is in Git anyway
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related

" Use spaces instead of tabs
set noexpandtab
set cindent
set cinoptions=:0,l1,t0,g0,(0
set softtabstop=8

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=8

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" Visual mode related

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

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

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=""
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
augroup DotfilesBasicLastEdit
  au!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line

" Always show the status line
set laststatus=2
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" Format the status line
set statusline=\ %{HasPaste()}%{LinterStatus()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings

" Allow cursor to go after one last character of the line, like in
" modern editing environments.
set virtualedit=onemore

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

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
  augroup DotfilesBasicBufWritePre
    au!
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
  augroup END
endif

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
" Misc

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

""""""""""""""""""""""""""""""
" Python section

let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- <esc>a
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#


""""""""""""""""""""""""""""""
" JavaScript section

au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

""""""""""""""""""""""""""""""
" CoffeeScript section

function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])

""""""""""""""""""""""""""""""
" Shell section

" All of my terminals are fully capable - forcing VIM
" to use true-colors on all of them here.

set termguicolors
set term=rxvt-unicode-256color

""""""""""""""""""""""""""""""
" Twig section
""""""""""""""""""""""""""""""
autocmd BufRead *.twig set syntax=html filetype=html

""""""""""""""""""""""""""""""
" Load pathogen paths
""""""""""""""""""""""""""""""
let s:vim_runtime = expand('<sfile>:p:h')
call pathogen#infect(s:vim_runtime.'/sources_forked/{}')
call pathogen#infect(s:vim_runtime.'/sources_non_forked/{}')
call pathogen#infect(s:vim_runtime.'/external/{}')
call pathogen#helptags()

""""""""""""""""""""""""""""""
" bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

""""""""""""""""""""""""""""""
" MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'

""""""""""""""""""""""""""""""
" snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>

""""""""""""""""""""""""""""""
" Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.o$']
let g:NERDTreeWinSize=35
" let NERDTreeMapOpenInTab='<ENTER>'
let NERDTreeQuitOnOpen=1

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-multiple-cursors

let g:multi_cursor_next_key="\<C-s>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" surround.vim config

" Annotate strings with gettext http://amix.dk/blog/post/19678
vmap Si S(i_<esc>f)
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimroom

let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-go

let g:go_fmt_command = "goimports"

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
" GUI related

" Set font according to system
if has("mac") || has("macunix")
    set gfn=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=Hack:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Colorscheme
set background=dark
colorscheme peaksea

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast editing and reloading of vimrc configs

map <leader>ee :e! ~/.vim_runtime/vimrc.vim<cr>
map <leader>eR :source ~/.vimrc<cr>
map <leader>ez :e! ~/.zsh/zshrc.sh<cr>
map <leader>et :e! ~/.tmux.conf<cr>
map <leader>ea :e! ~/.config/alacritty/alacritty.yml<cr>
map <leader>ex :e! ~/.Xdefaults<cr>
map <leader>eg :e! ~/.files/gitconfig<cr>
map <leader>ew :CtrlP ~/dkr<cr>
map <leader>eW :edit ~/dkr/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn persistent undo on

" Means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command mode related

" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
cno $q <C-\>eDeleteTillSlash()<cr>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omni complete functions
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windowing-related

set noea
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
  if l:display != "" && executable("xclip")
    call system('xclip -sel primary', a:string)
    call system('xclip -sel clipboard', a:string)
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

augroup myMarkdownEditSettings
  autocmd!
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

function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction

inoremap <Tab> <C-R>=CleverTab()<CR>

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
vmap <Cr> y
vmap <C-Cr> *``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Various mappings for function keys
nmap <F2> <C-c>
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

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

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
  " Remove ALL autocommands for the WhitespaceMatch group.
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

let g:syntastic_rust_checkers = ['rustc']
let g:racer_cmd = expand("$HOME/.cargo/bin/racer")
let g:rustc_syntax_only = 0
let $RUST_SRC_PATH = expand("$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src")
au FileType rust nmap <M-,> <Plug>(rust-def)

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

" File is not checked-in on purpose:

if filereadable(expand("~/.vim_runtime/project-specific.vim"))
" examples:
" call lh#local_vimrc#munge('whitelist', $HOME.'<some-path>')
" map <leader><tab>m :tabedit <some-path><cr>
  source ~/.vim_runtime/project-specific.vim
endif

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
