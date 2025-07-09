"
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vim
"
"

" <todo>
"
set encoding=utf-8

" <todo>
"
filetype plugin indent on

" <todo>
"
set autoread

" <todo>
"
let g:mapleader = ','
let g:maplocalleader = ','

" <todo>
"
set number
set cursorline
set signcolumn=no

" <todo>
"
set ignorecase
set smartcase
set incsearch
set hlsearch

" <todo>
"
set autoindent

" <todo>
"
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

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
set ttyfast
set lazyredraw
set updatetime=100
set timeoutlen=500

" <todo>
"
set diffopt+=iwhite
set diffopt+=algorithm:histogram
set diffopt+=indent-heuristic

" <todo>
"
if has('clipboard')
  set clipboard=unnamed

  if has('unnamedplus')
    set clipboard+=unnamedplus
  endif
endif

" Wayland clipboard workaround.
" This provides a manual way to use wl-copy & wl-paste for clipboard operations.
" See: https://github.com/vim/vim/issues/5157
if !empty($WAYLAND_DISPLAY) && executable('wl-copy') && executable('wl-paste')
  autocmd TextYankPost * call system('wl-copy --trim-newline', @0)
  
  vnoremap d d:call system('wl-copy --trim-newline', @")<CR>
  nnoremap p :r !wl-paste --no-newline<CR>
endif
