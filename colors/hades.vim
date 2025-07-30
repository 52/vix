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
var fg = '#ebebeb'

var dark = '#262626'
var pale = '#303030'
var hint = '#4e4e4e'

var yellow = '#e3c401'
var orange = '#f6722b'
var purple = '#f2affd'
var green = '#47b413'
var blue = '#24acd4'
var red = '#f62b5a'

### EDITOR HIGHLIGHTS
# 

Flush.Hi('Normal', fg, bg)
Flush.HiLink('Terminal', 'Normal')

# Cursor
Flush.Hi('Cursor', '', fg)
Flush.Hi('CursorLine', '', dark)
Flush.HiLink('CursorLineNr', 'CursorLine')
Flush.HiLink('CursorColumn', 'CursorLine')

# Line numbers
Flush.Hi('LineNr', hint, bg)
Flush.HiLink('LineNrAbove', 'LineNr')
Flush.HiLink('LineNrBelow', 'LineNr')

# Status line
Flush.HiLink('StatusLine', 'CursorLine')
Flush.HiLink('StatusLineNC', 'StatusLine')

# Columns
Flush.HiLink('SignColumn', 'LineNr')
Flush.HiLink('ColorColumn', 'CursorLine')

# Menus
Flush.Hi('Pmenu', fg, dark)
Flush.Hi('PmenuSel', '', pale)
Flush.HiLink('PmenuThumb', 'Cursor')
Flush.HiLink('PmenuSbar', 'PmenuSel')

# Visual
Flush.Hi('Visual', fg, pale)
Flush.HiLink('VisualNOS', 'Visual')

# Search
Flush.Hi('Search', fg, hint)
Flush.HiLink('CurSearch', 'Search')
Flush.HiLink('IncSearch', 'Search')

# Messages
Flush.Hi('InfoMsg', blue, bg)
Flush.Hi('ErrorMsg', red, bg)
Flush.Hi('WarningMsg', orange, bg)

# Diffs
Flush.Hi('DiffAdd', green, dark)
Flush.Hi('DiffDelete', red, dark)
Flush.Hi('DiffText', orange, dark)
Flush.Hi('DiffChange', yellow, dark)

# Tabs
Flush.Hi('TabLine', fg, dark)
Flush.Hi('TabLineSel', fg, pale)
Flush.HiLink('TabLineFill', 'TabLine')

# Specials
Flush.Hi('NonText', hint, '')
Flush.HiLink('SpecialKey', 'NonText')
Flush.HiLink('EndOfBuffer', 'NonText')

# Splits
Flush.HiLink('VertSplit', 'LineNr')

# Quickfix
Flush.Hi('QuickFixLine', '', pale)

# Pairs
Flush.Hi('MatchParen', yellow, '', 'bold')

### SYNTAX HIGHLIGHTS
#

# Comments
Flush.Hi('Comment', hint, '')

# Constants
Flush.Hi('Constant', fg, bg)
Flush.HiLink('String', 'Constant')
Flush.HiLink('Character', 'Constant')
Flush.HiLink('Number', 'Constant')
Flush.HiLink('Boolean', 'Constant')
Flush.HiLink('Float', 'Constant')

# Identifiers
Flush.Hi('Identifier', fg, bg)
Flush.HiLink('Function', 'Identifier')

# Statements
Flush.Hi('Statement', fg, bg)
Flush.HiLink('Conditional', 'Statement')
Flush.HiLink('Repeat', 'Statement')
Flush.HiLink('Label', 'Statement')
Flush.HiLink('Operator', 'Statement')
Flush.HiLink('Keyword', 'Statement')
Flush.HiLink('Exception', 'Statement')

# Preprocessor
Flush.Hi('PreProc', fg, bg)
Flush.HiLink('Include', 'PreProc')
Flush.HiLink('Define', 'PreProc')
Flush.HiLink('Macro', 'PreProc')
Flush.HiLink('PreCondit', 'PreProc')

# Types
Flush.Hi('Type', fg, bg)
Flush.HiLink('StorageClass', 'Type')
Flush.HiLink('Structure', 'Type')
Flush.HiLink('Typedef', 'Type')

# Special
Flush.Hi('Special', fg, bg)
Flush.HiLink('SpecialChar', 'Special')
Flush.HiLink('Tag', 'Special')
Flush.HiLink('Delimiter', 'Special')
Flush.HiLink('SpecialComment', 'Special')
Flush.HiLink('Debug', 'Special')
