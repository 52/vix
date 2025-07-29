""
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vix
"
"

if !has('vim9script')
  finish
endif

vim9script

# Reloads the direnv environment.
# This function executes 'direnv reload' to reload the environment.
def DirReload(): void
  if !executable('direnv')
    throw '[direnv.vim]: `direnv` command not found in $PATH'
  endif
  
  var output = system('direnv reload')

  if v:shell_error != 0
    throw '[direnv.vim]: failed to reload direnv: ' .. output
  endif

  echo '[direnv.vim]: successfully reloaded environment'
enddef

command! DirReload call DirReload()
