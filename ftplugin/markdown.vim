setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

nmap <buffer> gx <Plug>Markdown_OpenUrlUnderCursor
nmap <buffer> <cr> <Plug>Markdown_EditUrlUnderCursor

nnoremap <buffer> <leader>t :Toc<cr>
