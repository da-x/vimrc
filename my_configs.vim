set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windowing-related

set noea
map <tab> <c-w>
map <tab><tab> <c-w><c-w>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal fixups

" The code for Shift-Enter was specially invented.

map  <C-x>
map j <M-j>
map k <M-k>
map <ESC> <C-w>v
map <ESC> <C-w>s
map <ESC>[1;5C <C-Right>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5F <C-End>
map <ESC>[1;5H <C-Home>
map <ESC>[Z <S-tab>
map <ESC>h <A-h>
map <ESC>[5;30001~ <S-CR>
map!  <C-x>
map! j <M-j>
map! k <M-k>
map! , <M-,>
map! <ESC> <C-w>v
map! <ESC> <C-w>s
map! <ESC>[0;5D <C-Left>
map! <ESC>[1;5C <C-Right>
map! <ESC>[1;5F <C-End>
map! <ESC>[1;5H <C-Home>
map! <ESC>h <A-h>
map! <ESC>[5;30001~ <S-CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <F8>   :Explore<CR>
map <silent> <S-F8> :sp +Explore<CR>

" Moving text around, extremely handy when re-ordering code manually

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" Got used to this from other environments (go to start of file / end of file):

nmap <silent> <c-home> 1G
nmap <silent> <c-end> G

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Faster moving of the cursor using Ctrl and arrows

nnoremap <silent> <C-Up> {
nnoremap <silent> <C-Down> }
inoremap <silent> <C-Up> <Esc>{i
inoremap <silent> <C-Down> <Esc>}i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing

" Make Backspace behave like it normally does, in normal mode
nnoremap <BS> X

" Search replace the highlight marking, either in the entire buffer or in the
" currently selected region in visual mode.
nnoremap <A-h> :%s///g<left><left>
vnoremap <A-h> :s///g<left><left>

" Add a newline and move down
noremap <silent> <C-J> O<Esc>j

inoremap jK x<C-c>"_x

nmap K <Plug>(Man)

" Remap <Enter> to something more useful than 'line down'
nmap <CR> o

" Fixes it up for command mode:
nmap <S-CR> i<CR>
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Give indication in which mode we are at

au InsertEnter * hi Normal guibg=#002000
au InsertLeave * hi Normal guibg=#000000

" Fix it for C-c, which does not run the hooks above
inoremap <C-c> <C-c>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:local_vimrc = ['.git/vimrc_local.vim']

" File is not checked-in on purpose:

if filereadable(expand("~/.vim_runtime/project-specific.vim"))
    source ~/.vim_runtime/project-specific.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git-related stuff

let g:gitgutter_highlight_lines = 0

func! GitGrep(...)
	let save = &grepprg
	set grepprg=git\ grep\ -n\ $*
	let s = 'grep'
	for i in a:000
		let s = s . ' ' . i
	endfor
	exe s
	let &grepprg = save
endfun

command! -nargs=? G call GitGrep(<f-args>)

nmap <Leader>hu GitGutterUndoHunk<cr>

func! MyGitRebaseTodoHook(...)
    call setpos('.', [0, 1, 1, 0])
    nnoremap <buffer> p 0ciwpick<ESC><Down>0
    nnoremap <buffer> r 0ciwreword<ESC><Down>0
    nnoremap <buffer> e 0ciwedit<ESC><Down>0
    nnoremap <buffer> s 0ciwsquash<ESC><Down>0
    nnoremap <buffer> f 0ciwfixup<ESC><Down>0
    nnoremap <buffer> x 0ciwexec<ESC><Down>0
    nnoremap <buffer> d 0ciwdrop<ESC><Down>0
    nmap <buffer> <C-Up> <M-k>
    nmap <buffer> <C-Down> <M-j>
endfun

autocmd! BufRead git-rebase-todo call MyGitRebaseTodoHook()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emacs migration path:

unmap <C-x>
nnoremap <c-z> :undo<cr> 
inoremap <c-z> <ESC>:undo<cr>i
nnoremap <silent> <C-x>f :NERDTreeFind<cr>
nmap <esc>x <Nop>
