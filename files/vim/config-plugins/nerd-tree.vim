" NERDTree config
"""""""""""""""""""""""""

" If NERDTree is the last window open when I close Vim, close it.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle NERDTree
nnoremap <leader>m :NERDTreeToggle<CR>

" Show hidden files
let NERDTreeShowHidden=0
