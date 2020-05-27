" Keybinds config
""""""""""""""""""

" Some keybinds are moved to which key plugin and commented here for the moment
" When I see how it works I'll fix it

" General "

" Map leader to space
let mapleader = " "
" Quickly cancel search highlighting
nnoremap <leader><space> :nohlsearch<cr>
" Move buffer
"nnoremap <leader>bn :bNext<cr>
" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Move the selected block
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv
" TAB and shift TAB in general to move around buffers
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>
" Better tabbing, doesn't unselect after tab
vnoremap < <gv
vnoremap > >gv

" Plugins "

" Markdown Preview
" Toggle Markdown preview
nmap <leader>md <Plug>MarkdownPreviewToggle

" Coc
" Coc keybinds are in coc-nvim.vim

" GitGutter
" nmap <leader>tgg :GitGutterToggle<CR>

" NERDTree
" Toggle NERDTree
nnoremap <leader>m :NERDTreeToggle<CR>
