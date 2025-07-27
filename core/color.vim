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

# Enable syntax highlighting.
syntax enable

# Set the colorscheme.
colorscheme hades

# Displays the highlight group under the cursor.
# See: https://vim.fandom.com/wiki/Showing_syntax_highlight_group_in_statusline
def HlGroup(): void
  var item = synIDattr(synID(line("."), col("."), 1), "name")

  if empty(item)
    echo 'No highlight group'
    return
  endif

  echo item
enddef


# Displays a trace of the highlight group under the cursor.
# See: http://vim.wikia.com/wiki/VimTip99
def HlTrace(): void
  var item = synIDattr(synID(line('.'), col('.'), 1), 'name')
  var trans = synIDattr(synID(line('.'), col('.'), 0), 'name')
  var link = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')

  if empty(item)
    echo 'No highlight group'
    return
  endif

  if item !=# trans
    echo item .. ' (transparent: ' .. trans .. ') -> ' .. link
  elseif item !=# link
    echo item .. ' -> ' .. link
  else
    echo item
  endif
enddef

command! HlGroup call HlGroup()
command! HlTrace call HlTrace()
