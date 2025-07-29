""
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vix
"
"

if !has('vim9script') || !has('gui_running')
  finish
endif

vim9script

# Automatically copy selection to clipboard.
set guioptions+=a

# Maintain window dimensions on GUI changes.
set guioptions+=k

# Disable annoying GUI features.
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

# Set the default font.
var font = 'monospace'

# Set the default font size.
var font_size = 16

# Resets the font to the current 'font_size'.
# This function updates the 'guifont' option with the current values.
def FontReset(): void
  exec ':set guifont=' .. font .. '\ ' .. string(font_size)
enddef

# Increases the font size.
# This function increments 'font_size' and forces a reset.
def FontIncrease(): void
  font_size = font_size + 1
  call FontReset()
enddef

# Decreases the font size.
# This function decrements 'font_size' and forces a reset.
def FontDecrease(): void
  font_size = font_size - 1
  call FontReset()
enddef

augroup Font
  autocmd!
  autocmd GUIEnter * call FontReset()
augroup END

command! FontIncrease call FontIncrease()
command! FontDecrease call FontDecrease()

nnoremap <silent> <D-+> :FontIncrease<CR>
nnoremap <silent> <D--> :FontDecrease<CR>

