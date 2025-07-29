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
var fg = '#e8e8e8'

var dark = '#141414'
var hint = '#323232'
var gray = '#494141'

var yellow = '#e3c401'
var green = '#47b413'
var red = '#f62b5a'

### EDITOR HIGHLIGHTS
# 

Flush.Hi('Normal', fg, bg)
Flush.Hi('Terminal', fg, bg)

# Cursor
Flush.Hi('Cursor', bg, fg)
Flush.Hi('CursorLine', '', hint)
Flush.Hi('CursorLineNr', yellow, hint)
Flush.HiLink('CursorColumn', 'CursorLine')

# Line numbers
Flush.Hi('LineNr', gray, bg)
Flush.HiLink('LineNrAbove', 'LineNr')
Flush.HiLink('LineNrBelow', 'LineNr')

# Status line
Flush.Hi('StatusLine', fg, hint)
Flush.Hi('StatusLineNC', gray, hint)
