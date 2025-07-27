""
" hades v0.1.0
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

var bg = '#1c1c1c'
var fg = '#f6f6f6'

var dark = '#1e1a1a'
var hint = '#303030'
var gray = '#424242'

# var keyword
# var comment
# var string
# var number
# var func
# var type

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
Flush.Hi('LineNr', gray, dark)
Flush.HiLink('LineNrAbove', 'LineNr')
Flush.HiLink('LineNrBelow', 'LineNr')
