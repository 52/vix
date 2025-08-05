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

# Display the menu for a single candidate.
set completeopt+=menuone

# Display extra information about the current candidate.
set completeopt=popup

# Enable fuzzy-matching for candidates.
set completeopt+=fuzzy

# Disable automatic candidate insertion.
set completeopt+=noinsert

# Disable automatic candidate selection.
set completeopt+=noselect

# Enable keyword based fuzzy-matching.
set completefuzzycollect=keyword

# Register the LSP completion source.
set complete=FLspCompletor^12

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

# Enable command-line completions.
set wildmenu

# Display completions in a standard popup.
set wildoptions+=pum

# Enable fuzzy-matching for candidates.
set wildoptions+=fuzzy

# Enable sane <TAB> usage in the popup.
set wildmode=noselect:lastused,full

# Limit the number of candidates to n.
set pumheight=6

# Trigger the wildmenu on command-line input.
augroup CMDComplete
  autocmd!
  autocmd CmdlineChanged : wildtrigger()
augroup END
