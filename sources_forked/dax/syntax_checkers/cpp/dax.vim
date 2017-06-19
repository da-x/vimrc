if exists('g:loaded_syntastic_cpp_dax_checker')
    finish
endif
let g:loaded_syntastic_cpp_dax_checker = 1

let s:save_cpo = &cpo
set cpo&vim

let s:checker = expand('<sfile>:p:h') . syntastic#util#Slash() . 'check.py'

" echo s:checker

function! SyntaxCheckers_cfg_cfg_IsAvailable() dict
    return executable(self.getExec()) &&
        \ syntastic#util#versionIsAtLeast(
            \ self.getVersion(self.getExecEscaped() . ' -V'), [2, 4])
endfunction

function! SyntaxCheckers_cpp_dax_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'args_before': s:checker,
        \ 'args_after': ''})

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat':
        \     '%-G%f:%s:,' .
        \     '%f:%l:%c: %trror: %m,' .
        \     '%f:%l:%c: %tarning: %m,' .
        \     '%f:%l:%c: %m,'.
        \     '%f:%l: %trror: %m,'.
        \     '%f:%l: %tarning: %m,'.
        \     '%f:%l: %m'})
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'cpp',
    \ 'name': 'dax',
    \ 'exec': 'python'})

let &cpo = s:save_cpo
unlet s:save_cpo