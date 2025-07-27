"
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

# Enable insert mode completions.
set autocomplete

# Set the completion popup highlight group.
set completepopup=highlight:Pmenu

# Use a popup menu to display completions.
set completeopt+=menu

# Display extra information about the current selection.
set completeopt+=popup

# Preinsert the current selection.
set completeopt+=preinsert
