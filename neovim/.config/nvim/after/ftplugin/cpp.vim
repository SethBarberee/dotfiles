if &filetype !=# 'cpp' || v:version < 700
  finish
endif

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()

" Automatically add include/ dir on each base dir
let b:basePath=finddir('.git/..', expand('%:p:h').';')
exec "set path+=".b:basePath."/include"
