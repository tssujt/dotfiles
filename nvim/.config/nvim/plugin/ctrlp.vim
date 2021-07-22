let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>mru :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
\ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
\ }
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
" 如果安装了ag, 使用ag
noremap <Leader>c :Ack!<Space>
noremap <Leader>a :Ack <cword><cr>
if executable('ag')
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
" ag is fast enough that CtrlP doesn't need to cache
" let g:ctrlp_use_caching = 0
let g:ackprg = 'rg --vimgrep --color never --column'
" <Leader>c进行搜索，同时不自动打开第一个匹配的文件"
" 高亮搜索关键词
let g:ackhighlight = 1
" 修改快速预览窗口高度为15
let g:ack_qhandler = "botright copen 15"
" 在QuickFix窗口使用快捷键以后，自动关闭QuickFix窗口
let g:ack_autoclose = 0
" 使用ack的空白搜索，即不添加任何参数时对光标下的单词进行搜索，默认值为1，表示开启，置0以后使用空白搜索将返回错误信息
let g:ack_use_cword_for_empty_search = 1
" 部分功能受限，但对于大项目搜索速度较慢时可以尝试开启
" let g:ack_use_dispatch = 1
" using location list allows quick navigation using [l and ]l
cnoreabbrev ag LAck!
let g:ack_mappings = {
\ "t": "<C-W><CR><C-W>T",
\ "T": "<C-W><CR><C-W>TgT<C-W>j",
\ "o": "<CR>",
\ "O": "<CR><C-W>p<C-W>c",
\ "go": "<CR><C-W>p",
\ "h": "<C-W><CR><C-W>K",
\ "H": "<C-W><CR><C-W>K<C-W>b",
\ "v": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",
\ "gv": "<C-W><CR><C-W>H<C-W>b<C-W>J" }
endif

" ctrlpfunky
" ctrlp插件1 - 不用ctag进行函数快速跳转
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1

let g:ctrlp_extensions = ['funky']
