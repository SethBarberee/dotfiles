" Extra configuration for quickfix buffers
if &filetype !=# 'qf' || v:version < 700
  finish
endif

" we don't want quickfix buffers to pop up when doing :bn or :bp
set nobuflisted
