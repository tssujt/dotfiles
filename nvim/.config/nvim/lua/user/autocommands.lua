vim.cmd [[
    " In the quickfix window, <CR> is used to jump to the error under the
    " cursor, so undefine the mapping there.
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
    " quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
    autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
    autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K
    autocmd BufReadPost quickfix nnoremap <buffer> t <C-w><Enter><C-w>T

    " 打开自动定位到最后编辑的位置
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " 具体编辑文件类型的一般设置，比如不要 tab 等
    autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
    autocmd FileType ruby,javascript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
    autocmd FileType qf nnoremap <buffer> <Enter> <C-W><Enter><C-W>T
    autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown
    autocmd BufRead,BufNewFile *.part set filetype=html
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

    " Highlight TODO, FIXME, NOTE, etc.
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')

    au FileType python let b:delimitMate_nesting_quotes = ['"']
    au FileType php let delimitMate_matchpairs = "(:),[:],{:}"
]]
