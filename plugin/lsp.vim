""
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

# Register the defined LSP's with the 'yegappan/lsp' plugin.
# See: https://github.com/yegappan/lsp
def Register(): void
  # Filter LSP's with available executables.
  # This prevents errors from missing language servers.
  var arr = filter(copy(servers), (_, s) => !!executable(s.path))

  if !empty(arr)
    call('LspOptionsSet', [config])
    call('LspAddServer', [arr])
  endif
enddef

augroup VixLspSetup
  autocmd!
  # Register the LSP's.
  autocmd User LspSetup call Register()

  # Clear native completion when an LSP attaches to a buffer.
  # This prevents an overload of candidates from different sources.
  # When an LSP is available, resorting to 'omnifunc' is superior.
  autocmd User LspAttached setlocal complete=
augroup END
