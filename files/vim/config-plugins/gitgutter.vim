" GitGutter Config
"""""""""""""""""""
" This plugin shows the changes in the file over the last commit

highlight GitGutterAdd    guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0

" Show the number of changes if there are in the Airline bar
let g:airline#extensions#hunks#non_zero_only = 1
