" ALE config (replaces coc.nvim — lighter, no Node.js extension management,
" just needs the language servers/linters themselves on PATH)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use ALE's LSP completion (omnifunc), don't need a separate completion plugin
let g:ale_completion_enabled = 1

" Lint on save and leaving insert mode, not on every keystroke
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1

" Fix (format) on save, only using whatever fixers are configured per filetype
let g:ale_fix_on_save = 1

" Gutter signs
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" Show the message for the diagnostic under the cursor in a short line
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" LSP navigation
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gy :ALEGoToTypeDefinition<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <silent> K :ALEHover<CR>
