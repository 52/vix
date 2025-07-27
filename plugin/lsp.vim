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

# List of LSP definitions.
# See: https://github.com/yegappan/lsp/blob/main/doc/configs.md/
var servers = [
  {
    name: 'nixd',
    filetype: ['nix'],
    path: 'nixd',
    args: [],
  },
  {
    name: 'rust-analyzer',
    filetype: ['rust'],
    path: 'rust-analyzer',
    args: [],
    syncInit: true,
  },
]

# Default configuration options for the plugin.
# See: https://github.com/yegappan/lsp?tab=readme-ov-file#configuration/
var config = {
  autoComplete: false,
}

# Registers the defined LSP's with the 'yegappan/lsp' plugin.
# See: https://github.com/yegappan/lsp
def Register(): void
  var arr = filter(copy(servers), (_, s) => executable(s.path) ? v:true : v:false)
  if !empty(arr)
    call('LspAddServer', [arr])
  endif
enddef

augroup LSP
  autocmd!
  autocmd User LspSetup call LspOptionsSet(config)
  autocmd User LspSetup call Register()
augroup END
