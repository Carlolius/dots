" Keybinds config
""""""""""""""""""

" General keybinds the other ones are in WhichKey plugin configuration "

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
" Esc in insert mode
:imap jj <Esc>
