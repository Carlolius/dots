" OSCYank config — clipboard bridge for a Vim build with no native +clipboard
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Send every plain yank (not delete, not into a named register) to the
" terminal's clipboard via OSC52. Works locally and over SSH/tmux, since
" it's the terminal emulator that receives the escape code, not a process
" call — no dependency on wl-copy for this direction.
autocmd TextYankPost * if v:event.operator is# 'y' && v:event.regname is# ''
  \ | execute 'OSCYankRegister "' | endif

" Paste direction: OSC52 "read" is blocked by most terminals for security,
" so system->Vim paste goes through wl-paste instead (local Wayland only —
" over SSH, use the terminal's own native paste, which works independently
" of Vim registers).
if executable('wl-paste')
  nnoremap <silent> "+p :call setreg('"', system('wl-paste --no-newline'))<CR>p
  nnoremap <silent> "+P :call setreg('"', system('wl-paste --no-newline'))<CR>P
endif
