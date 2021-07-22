let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup MyQuickScope
  autocmd!
  autocmd FileType nvimtree,buffergator,tagbar,qf let b:qs_local_disable=1
augroup END
