"
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vim
"
"

" <todo>
"
filetype plugin indent on
syntax enable

" <todo>
"
let g:mapleader = ','
let g:maplocalleader = ','

" <todo>
"
set number
set cursorline
set signcolumn=yes
set background=dark
set termguicolors

" <todo>
"
set ignorecase
set smartcase
set incsearch
set hlsearch

" <todo>
"
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" <todo>
"
set nowrap
set scrolloff=10

" <todo>
"
set splitright
set splitbelow


" <todo>
"
set nofoldenable
set foldmethod=manual
set foldlevelstart=99

" <todo>
"
set backspace=indent,eol,start
set iskeyword+=-

" <todo>
"
set backup
set swapfile
set undofile
set undolevels=10000
set undoreload=10000

" <todo>
"
set backupdir=$XDG_STATE_HOME/vim/backup// | call mkdir(&backupdir, 'p')
set directory=$XDG_STATE_HOME/vim/swap//   | call mkdir(&directory, 'p')
set undodir=$XDG_STATE_HOME/vim/undo//     | call mkdir(&undodir, 'p')
set viewdir=$XDG_STATE_HOME/vim/view//     | call mkdir(&viewdir, 'p')
set viminfofile=$XDG_STATE_HOME/vim/viminfo

" <todo>
"
set lazyredraw
set updatetime=250
set timeoutlen=500

" <todo>
"
set diffopt+=iwhite
set diffopt+=algorithm:histogram
set diffopt+=indent-heuristic

" <todo>
"
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
endif
