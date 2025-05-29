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

var b0 = '#1d1d1d' # 1st background
var b1 = '#2f2f2f' # 2nd background

var f0 = '#f2f2f2' # 1st foreground
var f1 = '#b3b3b3' # 2nd foreground

### EDITOR HIGHLIGHTS
# 

Flush.Hi('Normal', f0, b0)
