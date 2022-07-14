" Extra configuration for quickfix buffers
if &filetype !=# 'qf' || v:version < 700
  finish
endif

setlocal norelativenumber
setlocal number

" we don't want quickfix buffers to pop up when doing :bn or :bp
set nobuflisted

if exists("b:undo_ftplugin")
    let b:undo_ftplugin .= "| setl wrap< rnu< nu< bl<"
else
    let b:undo_ftplugin = "setl wrap< rnu< nu< bl<"
endif
