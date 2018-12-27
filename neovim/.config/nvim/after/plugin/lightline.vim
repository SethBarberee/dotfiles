" Lightline

let g:lightline = {
    \ 'colorscheme': 'challenger_deep',
    \ 'active': {
    \   'left': [['mode', 'paste'],
    \            ['gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ ['lineinfo'],
    \           ['percent'],
    \           ['tagbar', 'fileencoding', 'filetype']],
    \ },
    \ 'inactive' : {
    \   'left': [['filename']],
    \   'right': [[ 'lineinfo'], [ 'percent']]
    \ },
    \ 'tabline': {
    \   'left': [['bufferinfo'],
    \             [ 'separator' ],
    \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
    \ },
    \ 'component': {
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \   'separator': '',
    \ },
    \ 'component_function': {
    \   'mode': 'LightlineMode',
    \   'gitbranch': 'gitbranch#name',
    \   'readonly': 'LightlineReadonly',
    \   'filetype': 'MyFiletype',
    \   'bufferinfo': 'lightline#buffer#bufferinfo',
    \ },
    \ 'component_expand': {
    \   'buffercurrent': 'lightline#buffer#buffercurrent',
    \   'bufferbefore': 'lightline#buffer#bufferbefore',
    \   'bufferafter': 'lightline#buffer#bufferafter',
    \ },
    \ 'component_type': {
    \   'buffercurrent': 'tabsel',
    \   'bufferbefore': 'raw',
    \   'bufferafter': 'raw',
    \ }
    \ }

function! LightlineMode()
    let fname = expand('%:t')
    if &filetype == 'denite'
        let mode_str = substitute(denite#get_status_mode(), '-\\| ', '', 'g')
        call lightline#link(tolower(mode_str[0]))
        return mode_str
    else
        return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
            \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
            \ &filetype ==# 'defx' ? 'Defx' :
            \ lightline#mode()
    endif
endfunction

let g:lightline#bufferline#unnamed = '[No Name]'

" Get rid of RO when looking at help pages
function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

" Add a devicon with the filetype
function! MyFiletype()
     return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : '' 
endfunction

" whether to show the buffer number of not
let g:lightline_buffer_show_bufnr = 0

" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'

" hide buffer list
let g:lightline_buffer_excludes = ['vimfiler']

" max file name length
let g:lightline_buffer_maxflen = 30

" max file extension length
let g:lightline_buffer_maxfextlen = 3

" min file name length
let g:lightline_buffer_minflen = 16

" min file extension length
let g:lightline_buffer_minfextlen = 3

" reserve length for other component (e.g. info, close)
let g:lightline_buffer_reservelen = 20

" enable devicons in lightline buffer
let g:lightline_buffer_enable_devicons = 1

