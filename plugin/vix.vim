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

# Whether the 'vix' developer mode is enabled.
# This prevents duplicate executions and allows status tracking.
if !exists('g:vix_dev_enabled')
  g:vix_dev_enabled = false
endif

# Reloads the 'vix' development environment.
# This function reloads 'direnv' and sources the current buffer.
# Note: Intended for use in the 'vix' repository.
def VixDevReload(): void
  exec 'DirReload'
  exec 'source' expand('%')
  echo '[dev.vim]: reloaded ' .. expand('%:t')
  redraw
enddef

# Enables the 'vix' development mode.
# When enabled, the environment is refreshed on write through ':VixDevReload'.
# Note: Intended for use in the 'vix' repository.
def VixDevEnable(): void
  if g:vix_dev_enabled 
    echoerr '[dev.vim]: dev-mode is already enabled'
    return
  endif

  augroup VixDev
    autocmd!
    autocmd BufWritePost *.vim call VixDevReload()
  augroup END

  g:vix_dev_enabled = true
  echo '[dev.vim]: dev-mode enabled'
enddef

# Disables the 'vix' development mode.
# This function clears the autocommand, and disables hot-reloading.
# Note: Intended for use in the 'vix' repository.
def VixDevDisable(): void
  if !g:vix_dev_enabled
    echoerr '[dev.vim]: dev-mode is already disabled'
    return
  endif

  augroup VixDev
    autocmd!
  augroup END

  g:vix_dev_enabled = false
  echo '[dev.vim]: dev-mode disabled'
enddef

command! VixDevReload call VixDevReload()
command! VixDevEnable call VixDevEnable()
command! VixDevDisable call VixDevDisable()
