if exists("b:did_indent") | finish | endif
let b:did_indent = 1

setlocal autoindent
setlocal nolisp
setlocal nosmartindent

setlocal indentexpr=GitRebaseIndentHook(v:lnum)

if exists("*GitRebaseIndentHook") | finish | endif

function GitRebaseIndentHook(lnum)
	return 0
endfunction

