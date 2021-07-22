nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>ge :Git diff<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gs :Git<CR>

let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 1
" nnoremap <leader>gs :GitGutterToggle<CR>

nnoremap <leader>hu :GitGutterUndoHunk<CR>
nnoremap <leader>hp :GitGutterPreviewHunk<CR>
nnoremap <Leader>hj :GitGutterPrevHunk<CR>
nnoremap <Leader>hk :GitGutterNextHunk<CR>
