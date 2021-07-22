nmap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_show_visibility = 1
" for ruby
let g:tagbar_type_ruby = {
\ 'kinds' : [
	\ 'm:modules',
	\ 'c:classes',
	\ 'd:describes',
	\ 'C:contexts',
	\ 'f:methods',
	\ 'F:singleton methods'
\ ]
\ }
