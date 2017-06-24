set nocompatible
set number
set shortmess+=at

" Make keystores the most predictable being time-independent:

set notimeout
set nottimeout

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
map <ESC>j <M-j>
map <ESC>k <M-k>
map <ESC>p <A-p>
map <ESC>t <A-t>
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
map! <ESC>[5;30005~ <C-A-CR>
map! <ESC>[5;30014~ <C-Space>
map! <ESC>j <M-j>
map! <ESC>k <M-k>
map! <ESC>p <A-p>
map! <ESC>t <A-t>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Give indication in which mode we are at, using a cursor shape

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

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

" Make Backspace behave like it normally does, in normal mode
nnoremap <BS> "_X

" Search replace the highlight marking, either in the entire buffer or in the
" currently selected region in visual mode.
nnoremap <A-h> :%s///g<left><left>
vnoremap <A-h> :s///g<left><left>

" Add a newline and move down
noremap <silent> <C-J> O<Esc>j

" Exit insert mode
inoremap jK x<C-c>"_x
map! <C-Delete> <C-c>
map <C-Delete> <Nop>

"
" Saner yanking and pasting behavior using <A-p> and <C-A-p>:
"
" * When yanking, put the cursor at the cursor right after the yanked region,
"   whether it is multiple lines or not.
" * When pasting, put the cursor either at the beginning of the pasted text or
"   after its end.
"

function! NextCharacter()
  let l:line = getcurpos()[1]
  let l:col = getcurpos()[2]
  let len = strlen(getline('.'))
  if len > l:col
     call cursor(l:line, l:col + 1)
  else
     call cursor(l:line+1, 1)
  endif
endfunction

" function! PrevCharacter()
"   let l:line = getcurpos()[1]
"   let l:col = getcurpos()[2]
"   let len = strlen(getline(l:line - 1))
"   if l:col == 1
"      call cursor(l:line - 1, len)
"   else
"      call cursor(l:line, l:col - 1)
"   endif
" endfunction

function! PasteBeforeHack()
  let l:line = getcurpos()[1]
  let l:col = getcurpos()[2]
  execute "normal! P"
  call cursor(l:line, l:col)
endfunction

vnoremap <silent> y y`]:call NextCharacter()<cr>
noremap <silent> <A-p> :call PasteBeforeHack()<cr>
inoremap <silent> <C-A-p> <C-R>"
inoremap <silent> <A-p> <nop>
noremap <C-A-p> gP

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

" Single character insertion
noremap <silent> <A-a> "=nr2char(getchar())<cr>P

imap <S-CR> <cr>

function! SetPerBufferActions()
  " A more useful biding for Enter in normal mode
  if &buftype ==# ''  &&  &filetype != 'qf'
    nmap <buffer> <CR> o
    nmap <buffer> <S-CR> O
  endif

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

vmap <A-t> #*
imap <A-t> <C-c>#*
nmap <A-t> #*

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
" Modern-like selections

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Various mappings for function keys
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

let g:local_vimrc = ['.git/vimrc_local.vim']

" File is not checked-in on purpose:

if filereadable(expand("~/.vim_runtime/project-specific.vim"))
  source ~/.vim_runtime/project-specific.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-rooter

let g:rooter_patterns = ['.git', '.git/', 'Cargo.toml', 'Makefile']
let g:rooter_change_directory_for_non_project_files = 'current'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Grepper

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nmap <F9> :Grepper -noquickfix -noprompt -cword<cr>
nmap <C-F9> :Grepper -noquickfix -cword<cr>

let g:grepper = {
        \ 'tools': ['git', 'grep'],
        \ }

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
