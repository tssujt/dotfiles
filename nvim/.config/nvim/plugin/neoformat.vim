let g:neoformat_only_msg_on_error = 0
let g:neoformat_verbose = 1
let g:neoformat_enabled_python = ['black', 'isort']

let g:neoformat_python_black = {
\ 'exe': 'black',
\ 'args': ['-'],
\ 'stdin': 1,
\ }
let g:neoformat_python_isort = {
\ 'exe': 'isort',
\ 'args': ['-'],
\ 'stdin': 1,
\ }

" autocmd BufWritePre *.py execute ':Neoformat'
nmap <leader>nf :Neoformat<cr>
