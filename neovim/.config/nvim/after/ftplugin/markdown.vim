" Extra configuration for Markdown documents
if &filetype !=# 'markdown' || v:version < 700
  finish
endif

" Spellchecking features
if has('spell')

  " Spellcheck documents we're actually editing (not just viewing)
  if &modifiable && !&readonly
    setlocal spell
    let b:undo_ftplugin .= '|setlocal spell<'
  endif

  " Tolerate leading lowercase letters in README.md files, for things like
  " headings being filenames
  if expand('%:t') ==# 'README.md'
    setlocal spellcapcheck=
    let b:undo_ftplugin .= '|setlocal spellcapcheck<'
  endif

endif
