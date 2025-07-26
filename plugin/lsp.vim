"
"
" SPDX-License-Identifier: MIT
" Author: Max Karou <maxkarou@protonmail.com>
" URL: https://github.com/52/vix
"
"

" Registers an LSP server with the 'yegappan/lsp' plugin.
" See: https://github.com/yegappan/lsp
function! s:register_lsp_server(name, filetype, path, args) abort
  if !executable(a:path)
    " Uncomment if needed for debugging:
    " echom 'LSP executable not found: ' . a:path
    return
  endif

  let l:server = #{
    \   name: a:name,
    \   filetype: a:filetype,
    \   path: a:path,
    \   args: a:args
    \ }

  call LspAddServer([l:server])
endfunction

" Modify the default LSP configuration on startup.
augroup lsp_config
  autocmd!
augroup END

" Register configured LSP's on startup.
augroup lsp_servers
  autocmd!
  autocmd VimEnter * call s:register_lsp_server('nixd', ['nix'], 'nixd', [])
  autocmd VimEnter * call s:register_lsp_server('rustlang', ['rust'], 'rust-analyzer', [])
  autocmd VimEnter * call s:register_lsp_server('vimlsp', ['vim'], 'vim-language-server', ['--stdio'])
augroup END
