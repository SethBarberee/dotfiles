" Extra configuration for help documents
if &filetype !=# 'help' || v:version < 700
  finish
endif

" Turn off relative numbers and normal numbers in help buffers
augroup number
    setlocal norelativenumber nonumber
    let b:undo_ftplugin .='|setlocal number relativenumber<'
augroup END
