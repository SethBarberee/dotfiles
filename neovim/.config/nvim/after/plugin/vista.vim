if !exists(':Vista')
    finish
endif

"let g:vista_icon_indent = ["▸ ", ""]
let g:vista_icon_indent = ['╰─▸ ', '├─▸ ']

let g:vista_sidebar_width = 50

let g:vista_default_executive = 'nvim_lsp'
let g:vista_finder_alternative_executives = 'ctags'
let g:vista_echo_cursor_strategy = 'both' " floating_win and echo

" Fallback to ctags for asm and vim
let g:vista_executive_for = {
    \ 'asm': 'ctags',
    \ 'vim': 'ctags',
    \ }

" Open if not opened and close if already opened
map <C-T> :Vista!! <Enter>
