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

# Configures buffer-local settings for writing commits.
# Applies formatting guidelines and enables spell checking.
# See: https://git-scm.com/docs/git-commit#_discussion
def SetupGitBuffer(): void
  # Highlight when exceeding the subject line after column 50.
  # This solely applies to the first line.
  matchadd('Error', '\%1l.\{50}\zs.*', 100)
  
  # Highlight when exceeding the 72nd column.
  # This only matches lines starting with standard characters.
  matchadd('Error', '^\w.\{71}\zs.*', 90)

  # Temporarily disable autocomplete.
  setlocal noautocomplete
enddef

augroup VixGitSetup
  autocmd!
  # Apply commit message buffer settings.
  # This applies to both the filetype and direct edits.
  autocmd FileType gitcommit call SetupGitBuffer()
  autocmd BufNewFile,BufRead COMMIT_EDITMSG call SetupGitBuffer()
augroup END
