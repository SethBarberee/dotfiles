" Extra configuration for text files
if &filetype !=# 'text' || v:version < 700
  finish
endif

" Spellcheck documents we're actually editing (not just viewing)
if has('spell') && &modifiable && !&readonly
  setlocal spell
  let b:undo_ftplugin .= '|setlocal spell<'
endif
