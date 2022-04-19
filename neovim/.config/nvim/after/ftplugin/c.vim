if &filetype !=# 'c' || v:version < 700
  finish
endif

" Automatically add include/ dir on each base dir
let b:basePath=finddir('.git/..', expand('%:p:h').';')
exec "set path+=".b:basePath."/include"
