"
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vim
"
"

if v:version < 901
  finish
endif

vim9script

import 'libcolor.vim' as libcolor

# Cache for storing `gui:cterm` color mappings.
# This prevents redundant approximations for frequently used colors.
# The chace persists across colorscheme reloads.
if !exists('g:flush_cterm_cache')
  g:flush_cterm_cache = {}
endif

# Define colors and attributes for a highlight group.
export def Hi(group: string, fg: string, bg: string, gui: string = '', term: string = '')
  if empty(group)
    throw '[flush.vim]: `group` name is a required argument'
  endif

  var guifg = empty(fg) ? 'NONE' : fg
  var guibg = empty(bg) ? 'NONE' : bg
  var gui_attr = empty(gui) ? 'NONE' : gui
  var term_attr = empty(term) ? 'NONE' : term
  
  var ctermfg = GetCtermColor(guifg)
  var ctermbg = GetCtermColor(guibg)
  
  var cmd = 'highlight ' .. group
  cmd ..= ' guifg=' .. guifg
  cmd ..= ' guibg=' .. guibg
  cmd ..= ' ctermfg=' .. ctermfg
  cmd ..= ' ctermbg=' .. ctermbg
  cmd ..= ' gui=' .. gui_attr
  cmd ..= ' cterm=' .. gui_attr
  cmd ..= ' term=' .. term_attr
  
  execute cmd
enddef

# Define links between highlight groups.
export def HiLink(src: string, dest: string)
  if empty(src) || empty(dest)
    throw '[flush.vim]: `src` and `dest` groups are required for linking'
  endif

  execute 'hi link' src dest
enddef

# Approximate the terminal color for a hex color.
def GetCtermColor(str: string): string
  if tolower(str) ==# 'none'
    return 'NONE'
  endif

  if str !~# '^#[0-9a-fA-F]\{6}$'
    throw '[flush.vim]: `str` must be a hex color code'
  endif

  var colorcode = str[1 :]
  
  if has_key(g:flush_cterm_cache, colorcode)
    return g:flush_cterm_cache[colorcode]
  endif
  
  var approx = libcolor.Approximate(str)
  var cterm_color = approx.xterm->string()

  g:flush_cterm_cache[colorcode] = cterm_color
  return cterm_color
enddef
