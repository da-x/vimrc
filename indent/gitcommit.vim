if exists("b:did_indent") | finish | endif
let b:did_indent = 1

setlocal autoindent		
setlocal nolisp
setlocal nosmartindent

setlocal indentexpr=GitCommitIndentHook(v:lnum)

if exists("*GitCommitIndentHook") | finish | endif

function GitCommitIndentHook(lnum)
	return 0
endfunction
