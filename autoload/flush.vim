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

import 'libcolor.vim' as libcolor

# Cache for storing 'gui:cterm' color mappings.
# This prevents redundant approximations for frequently used colors.
# The cache persists across colorscheme reloads.
if !exists('g:flush_cterm_cache')
  g:flush_cterm_cache = {}
endif

# Define colors and attributes for a highlight group.
# This function sets GUI and terminal colors with optional attributes.
export def Hi(group: string, fg: string, bg: string, gui: string = '', term: string = '')
  if empty(group)
    throw '[flush.vim]: `group` name is a required argument'
  endif

  var guifg = empty(fg) ? 'NONE' : fg
  var guibg = empty(bg) ? 'NONE' : bg
  var guiattr = empty(gui) ? 'NONE' : gui
  var termattr = empty(term) ? 'NONE' : term
  
  var ctermfg = ApproximateCtermColor(guifg)
  var ctermbg = ApproximateCtermColor(guibg)
  
  var cmd = 'highlight ' .. group
  cmd ..= ' guifg=' .. guifg
  cmd ..= ' guibg=' .. guibg
  cmd ..= ' ctermfg=' .. ctermfg
  cmd ..= ' ctermbg=' .. ctermbg
  cmd ..= ' gui=' .. guiattr
  cmd ..= ' cterm=' .. guiattr
  cmd ..= ' term=' .. termattr
  
  execute cmd
enddef

# Define links between highlight groups.
# This function links the source to the destination group.
export def HiLink(src: string, dest: string)
  if empty(src) || empty(dest)
    throw '[flush.vim]: `src` and `dest` groups are required for linking'
  endif

  execute 'hi! link' src dest
enddef

# Approximate the terminal color for a hex color.
# This function uses 'libcolor' approximation and caches the result.
def ApproximateCtermColor(str: string): string
  if tolower(str) ==# 'none'
    return 'NONE'
  endif

  if str !~# '^#[0-9a-fA-F]\{6}$'
    throw '[flush.vim]: `str` must be a hex color code'
  endif

  var color_code = str[1 :]
  
  if has_key(g:flush_cterm_cache, color_code)
    return g:flush_cterm_cache[color_code]
  endif
  
  var approx = libcolor.Approximate(str)
  var cterm_color = approx.xterm->string()

  g:flush_cterm_cache[color_code] = cterm_color
  return cterm_color
enddef
