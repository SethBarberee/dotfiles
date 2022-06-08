if &filetype !=# 'vim'
  finish
endif

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
