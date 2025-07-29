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

# Reloads the 'vix' development environment.
# This function reloads 'direnv' and sources the current buffer.
# Note: Intended for use in the 'vix' repository.
def VixDevReload(): void
  exec 'DeReload'
  exec 'source' expand('%')
  echo '[dev.vim]: reloaded ' .. expand('%:t')
enddef

# Enables the 'vix' development mode.
# When enabled, the environment is refreshed on write through ':VixDevReload'.
# Note: Intended for use in the 'vix' repository.
def VixDevEnable(): void
  augroup VixDev
    autocmd!
    autocmd BufWritePost *.vim call VixDevReload()
  augroup END
  echo '[dev.vim]: dev-mode enabled'
enddef

# Disables the 'vix' development mode.
# This function clears the autocommand, and disables hot-reloading.
# Note: Intended for use in the 'vix' repository.
def VixDevDisable(): void
  augroup VixDev
    autocmd!
  augroup END
  echo '[dev.vim]: dev-mode disabled'
enddef

command! VixDevReload call VixDevReload()
command! VixDevEnable call VixDevEnable()
command! VixDevDisable call VixDevDisable()
