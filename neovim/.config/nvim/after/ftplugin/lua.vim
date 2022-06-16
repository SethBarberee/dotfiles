if &filetype !=# 'lua'
  finish
endif

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()

