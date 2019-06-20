if !exists(':Vista')
    finish
endif

let g:vista_icon_indent = ["▸ ", ""]

let g:vista_sidebar_width = 50

" Open if not opened and close if already opened
map <C-T> :Vista!! <Enter>
