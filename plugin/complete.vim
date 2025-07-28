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

# Enable insert mode completions.
set autocomplete

# Set the completion popup highlight group.
set completepopup=highlight:Pmenu

# Use a popup menu to display completions.
set completeopt+=menu

# Display extra information about the current candidate.
set completeopt+=popup

# Preinsert the current candidate.
set completeopt+=preinsert

# Register the LSP completion source.
set complete=FLspCompletor

# LSP completion provided by the 'yegappan/lsp' plugin.
# This function is as wrapper to handle async completion requests.
# See: https://github.com/yegappan/lsp/blob/main/autoload/lsp/completion.vim#L495/
def g:LspCompletor(findstart: number, base: string): any
  # Ensure omnifunc is correctly set to the LSP handler.
  # Otherwise, cancel the operation but remain in completion mode.
  if &l:omnifunc != 'g:LspOmniFunc'
    return -2
  endif

  # Ensure the required LSP functions exist before proceeding.
  # Otherwise, cancel the operation and leave completion mode.
  if !exists('*g:LspOmniFunc') || !exists('*g:LspOmniCompletePending')
    return -3
  endif

  if findstart == 1
    # Determine the starting column position.
    # Note: Returns the column where the completion text begins.
    return g:LspOmniFunc(findstart, base)
  elseif findstart == 2
    # Check if async completion requests are pending.
    # Note: Returns 0, to continue polling the function.
    # Note: Returns 1, if the completion results are ready.
    return g:LspOmniCompletePending() ? 0 : 1
  else
    # Retrieve the matches based on the input base.
    # Note: Returns a list of candidates from the LSP.
    return g:LspOmniFunc(findstart, base)
  endif
enddef
