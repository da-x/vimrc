function! RustConvertIfLetToMatch()
  let l:pos = getpos('.')
  let l:next_start_block = searchpos('{', 'zn')
  normal! j
  let l:prev_if_let = searchpos('if let ', 'znb')
  call setpos('.', l:pos)

  if [0, 0] ==# l:next_start_block
    return
  endif
  if [0, 0] ==# l:prev_if_let
    return
  endif

  call setpos('.', [0, l:prev_if_let[0], l:prev_if_let[1] + 6, 0])
  let l:next_equality = searchpos('=', 'zn')

  if l:next_equality[0] != l:prev_if_let[0]
    call setpos('.', l:pos)
    return
  endif
  if l:next_equality[0] != l:next_start_block[0]
    call setpos('.', l:pos)
    return
  endif

  call setpos('.', [0, l:next_start_block[0], l:next_start_block[1] + 1, 0])
  let l:end_block = searchpairpos('{', '', '}', 'nz')
  let l:block_ending_line = getline(l:end_block[0])

  let l:has_else = v:false
  if l:block_ending_line =~# '\V\ \*} else {'
    let l:has_else = v:true
  endif

  call setpos('.', [0, l:end_block[0] + 1, 0, 0])
  let l:else_block_end = searchpairpos('{', '', '}', 'nz')
  call setpos('.', [0, l:next_start_block[0], l:next_start_block[1] + 1, 0])

  let l:line = getline('.')
  let l:s = ''
    \. l:line[0:l:prev_if_let[1] - 2]
    \. 'match'
    \. l:line[l:next_equality[1]:l:next_start_block[1]]
  call setline(l:prev_if_let[0], l:s)

  let l:s = ''
    \. l:line[l:prev_if_let[1]+6:l:next_equality[1]- 2]
    \. '=> {'
  call append(line('.'), l:s)
  normal! j==
  call setpos('.', [0, l:end_block[0], l:end_block[1] + 1, 0])
  call append(line('.'), '}')

  silent exec 'normal! '. l:next_start_block[0] .'G='. (l:end_block[0] + 1) .'G'

  if l:has_else
    call setline(l:end_block[0] + 2, '_ => {')
    call append(l:else_block_end[0] + 1, '}')
    silent exec 'normal! '. (l:end_block[0] + 2) .'G='. (l:else_block_end[0] + 2) .'G'
  endif

  call setpos('.', [0, l:next_start_block[0], l:next_start_block[1] + 1, 0])
endfun

nnoremap eim :call RustConvertIfLetToMatch()<CR>
