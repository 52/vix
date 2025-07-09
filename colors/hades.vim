""
" hades v0.1.0
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

import autoload 'flush.vim' as Flush

hi clear

if has('termguicolors')
  set termguicolors
endif

if exists("syntax on")
  syntax reset
endif

g:colors_name = "hades"
set background=dark

### COLOR PALETTE
#

var bg = '#141313'
var bg_alt = '#3b3b3b'

var fg = '#ebebeb'

### EDITOR HIGHLIGHTS
# 

Flush.Hi('Normal', fg, bg)
Flush.Hi('Terminal', fg, bg)

# Cursor
Flush.Hi('Cursor', bg, fg)
Flush.Hi('CursorLine', '', bg_alt)
Flush.HiLink('CursorColumn', 'CursorLine')
