let g:neoformat_only_msg_on_error = 1
let g:neoformat_enabled_python = ['black', 'isort']

let g:neoformat_python_black = {
\ 'exe': 'black',
\ 'replace': 1,
\ 'stdin': 1,
\ 'valid_exit_codes': [0, 23],
\ 'no_append': 1,
\ }
let g:neoformat_python_isort = {
\ 'exe': 'isort',
\ 'replace': 1,
\ 'stdin': 1,
\ 'valid_exit_codes': [0, 23],
\ 'no_append': 1,
\ }

" autocmd BufWritePre *.py execute ':Neoformat'
nmap <leader>nf :Neoformat<cr>
