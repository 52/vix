"
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vim
"
"

" <todo>
"
set nocompatible

" <todo>
"
function! s:env(key, fallback) abort
  if empty(getenv(a:key))
    call setenv(a:key, expand(a:fallback))
  endif
endfunction

call s:env('XDG_CACHE_HOME',  '~/.cache')
call s:env('XDG_CONFIG_HOME', '~/.config')
call s:env('XDG_STATE_HOME',  '~/.local/state')
call s:env('XDG_DATA_HOME',   '~/.local/share')

" <todo>
"
runtime! core/*.vim
