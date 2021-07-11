if &filetype !=# 'python' || v:version < 700
  finish
endif

if has_key(plugs, "nvim-treesitter")
    setlocal foldmethod=expr
    setlocal foldexpr=nvim_treesitter#foldexpr()
endif
