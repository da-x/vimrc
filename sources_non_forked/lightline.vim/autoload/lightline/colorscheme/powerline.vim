" =============================================================================
" Filename: autoload/lightline/colorscheme/powerline.vim
" Author: itchyny
" License: MIT License
" Last Change: 2013/09/07 15:54:41.
" =============================================================================

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ ['darkestgreen', 'brightgreen', 'bold'], ['white', 'darkgreen'] ]
let s:p.normal.right = [ ['darkestgreen', 'mediumgreen'], ['black', 'darkgreen'], ['mediumgreen', 'darkestgreen'] ]
let s:p.inactive.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray4', 'gray0'] ]
let s:p.inactive.left = [ [ '#ffffff', '#333333'] ]
let s:p.inactive.middle = [ [ 'gray7', '#222222' ] ]
let s:p.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
let s:p.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:p.replace.left = [ ['white', 'brightred', 'bold'], ['white', 'darkred'] ]
let s:p.visual.left = [ ['darkred', 'brightorange', 'bold'], ['white', 'gray4'] ]
let s:p.visual.middle = [ [ 'mediumred', 'darkestred' ] ]
let s:p.visual.right = [ ['darkestred', 'mediumred'], ['black', 'darkred'], ['mediumred', 'darkestred'] ]
let s:p.normal.middle = [ [ 'mediumgreen', 'darkestgreen' ] ]
let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let s:p.replace.middle = [ [ 'mediumred', 'darkestred' ] ]
let s:p.replace.right = [ ['darkestred', 'mediumred'], ['black', 'darkred'], ['mediumred', 'darkestred'] ]
let s:p.tabline.left = [ [ 'gray9', 'gray1' ] ]
let s:p.tabline.tabsel = [ [ 'gray3', '#dddddd' ] ]
let s:p.tabline.middle = [ [ 'gray2', 'gray4' ] ]
let s:p.tabline.right = [ [ 'gray9', 'gray1' ] ]
let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]

let g:lightline#colorscheme#powerline#palette = lightline#colorscheme#fill(s:p)
