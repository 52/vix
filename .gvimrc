"
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vim
"
"

" <todo>
"
set guioptions+=a

" <todo>
"
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

" <todo>
"
let s:font = 'monospace'
let s:font_size = 14

" <todo>
"
function! s:font_reset()
    exe ':set guifont=' . s:font . '\ ' . string(s:font_size)
endfunction

" <todo>
"
function! s:font_increase()
  let s:font_size = s:font_size + 1
  call s:font_reset()
endfunction

" <todo>
"
function! s:font_decrease()
  let s:font_size = s:font_size - 1
  call s:font_reset()
endfunction

command! FontIncrease call s:font_increase()
command! FontDecrease call s:font_decrease()

nnoremap <silent> <D--> :FontDecrease<CR>
nnoremap <silent> <D-+> :FontIncrease<CR>
