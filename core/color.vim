"
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vix
"
"

" Enable syntax highlighting.
syntax enable

" Set the colorscheme.
colorscheme hades

" Displays the highlight group under the cursor.
" See: https://vim.fandom.com/wiki/Showing_syntax_highlight_group_in_statusline
function! s:hlgroup() abort
  let l:item = synIDattr(synID(line("."),col("."),1),"name")

  if empty(l:item)
    echo 'No highlight group'
    return
  endif

  echo item
endfunction


" Displays a trace of the highlight group under the cursor.
" See: http://vim.wikia.com/wiki/VimTip99
function s:hltrace() abort
  let l:item = synIDattr(synID(line('.'),col('.'),1),'name')
  let l:trans = synIDattr(synID(line('.'),col('.'),0),'name')
  let l:link = synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name')

  if empty(l:item)
    echo 'No highlight group'
    return
  endif

  if l:item !=# l:trans
    echo l:item . ' (transparent: ' . l:trans . ') -> ' . l:link
  elseif l:item !=# l:link
    echo l:item . ' -> ' . l:link
  else
    echo l:item
  endif
endfunction

command! HlGroup call s:hlgroup()
command! HlTrace call s:hltrace()
