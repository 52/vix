""
" hades v0.1.0
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vix
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

var bg = '#242424'
var fg = '#f5f5f5'

var dark = '#181414'
var hint = '#282828'
var gray = '#424242'

### EDITOR HIGHLIGHTS
# 

Flush.Hi('Normal', fg, bg)
Flush.Hi('Terminal', fg, bg)

# Cursor
Flush.Hi('Cursor', bg, fg)
Flush.Hi('CursorLine', '', hint)
Flush.Hi('CursorLineNr', '', hint)
Flush.HiLink('CursorColumn', 'CursorLine')

# Line numbers
Flush.Hi('LineNr', gray, bg)
Flush.HiLink('LineNrAbove', 'LineNr')
Flush.HiLink('LineNrBelow', 'LineNr')
