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
set completeopt=menuone

# Display extra information about the current candidate.
set completeopt+=popup

# Enable fuzzy-matching for candidates.
set completeopt+=fuzzy

# Disable automatic candidate insertion.
set completeopt+=noinsert

# Disable automatic candidate selection.
set completeopt+=noselect

# Enable keyword based fuzzy-matching.
set completefuzzycollect=keyword

# Register the completion sources.
set complete=.

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

augroup VixCmpSetup
  autocmd!
  # Trigger the wildmenu on command-line input.
  autocmd CmdlineChanged [:/\?] call wildtrigger()
augroup END
