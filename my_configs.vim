set nocompatible
set number
set shortmess+=at

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windowing-related

set noea
map <tab> <c-w>
map <tab><tab> <c-w><c-w>
map <tab>\ <c-w>v
map <tab>- <c-w>s

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal fixups

silent exec "!stty -ixon"

" The ANSI codes for Shift-Enter were specially invented.

map  <C-x>
map  <C-s>
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
map <ESC>[5;30004~ <C-S-s>
map <ESC>[1;5Q <C-F2>
map <ESC>[1;5R <C-F3>
map <ESC>[1;5S <C-F4>
map <ESC>[1;3S <M-F4>
map <ESC>[5;3~ <M-PageUp>
map <ESC>[6;3~ <M-PageDown>

map!  <C-x>
map!  <C-s>
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
map! <ESC>[5;30004~ <C-S-s>
map! <ESC>[1;5Q <C-F2>
map! <ESC>[1;5R <C-F3>
map! <ESC>[1;5S <C-F4>
map! <ESC>[1;3S <M-F4>
map! <ESC>[5;3~ <M-PageUp>
map! <ESC>[6;3~ <M-PageDown>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Faster moving of the cursor using Ctrl and arrows

nnoremap <silent> <C-Up> {
nnoremap <silent> <C-Down> }
inoremap <silent> <C-Up> <C-c>{i
inoremap <silent> <C-Down> <C-c>}i
vnoremap <silent> <C-Up> {
vnoremap <silent> <C-Down> }

" Got used to this from other environments (go to start of file / end of file):

nmap <silent> <c-home> 1G
nmap <silent> <c-end> G

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

" Exit insert mode
inoremap jK x<C-c>"_x

" Remap <Enter> to something more useful than 'line down'
nmap <CR> o

" Fixes it up for command mode:
augroup myEnterRebinding
  autocmd!
  nmap <S-CR> i<CR>
  autocmd CmdwinEnter * nnoremap <CR> <CR>
  autocmd BufReadPost quickfix nnoremap <CR> <CR>
augroup END

" By file type
function! VimEvalLine()
  execute getline(".")
  echo 'Line evaluted'
endfunction

function! MyVimEditSettings()
  setlocal ts=1 sw=2 expandtab
  nnoremap <buffer> <C-x>e call VimEvalLine()
endfunction

augroup myVimEditSettings
  autocmd!
  autocmd Filetype vim call MyVimEditSettings()
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
" Misc

" Look for a man page
nmap K <Plug>(Man)

" Search
nmap <C-s> /
nmap <C-S-s> ?

nmap <F2> <C-c>
map! <F2> <Nop>
imap <F2> <C-c><F2>
nmap <C-F2> <leader>f
map! <C-F2> <Nop>
imap <C-F2> <C-c><C-F2>
nmap <F3> :NERDTreeFind<cr>
map! <F3> <Nop>
imap <F3> <C-c><F3>
nmap <C-F3> :NERDTreeToggle<cr>
map! <C-F3> <Nop>
imap <C-F3> <C-c><F3>

" Navigate location lists
nmap <F4> :lnext<cr>
map! <F4> <Nop>
imap <F4> <C-c><F4>
nmap <M-F4> :lprev<cr>
map! <M-F4> <Nop>
imap <M-F4> <C-c><M-F4>
nmap <C-F4> :lfirst<cr>
map! <C-F4> <Nop>
imap <C-F4> <C-c><C-F4>

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
" Give indication in which mode we are at

au InsertEnter * hi Normal guibg=#002000
au InsertLeave * hi Normal guibg=#000000

" Fix it for C-c, which does not run the hooks above
inoremap <C-c> <C-c>

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
let g:linuxsty_patterns = ['_only_used_per_tree']

func! Indent4Spaces(...)
  setlocal expandtab

  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal nosmarttab
endfun

command! Indent4Spaces call Indent4Spaces()

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

augroup myEnterRebinding
  autocmd!
  autocmd! BufRead git-rebase-todo call MyGitRebaseTodoHook()
augroup END

func! Gamd()
   silent exec "Gcommit --amend -a --no-edit"
   echo "File saved, all added and commit amended"
   silent w
endfun

command! -bar Gamd call Gamd()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emacs migration path:

unmap <C-x>
nnoremap <c-z> :undo<cr>
inoremap <c-z> <ESC>:undo<cr>i
nnoremap <silent> <C-x>f :NERDTreeFind<cr>
nmap <esc>x <Nop>

" Saving from anywhere
inoremap <C-x>s <C-c>:w<cr>
inoremap <C-x><C-s> <C-c>:w<cr>
nnoremap <C-x>s :w<cr>
nnoremap <C-x><C-s> :w<cr>
inoremap <C-x>q <C-c>:q<cr>
inoremap <C-x><C-q> <C-c>:q<cr>
nnoremap <C-x>q :q<cr>
nnoremap <C-x><C-q> :q<cr>
