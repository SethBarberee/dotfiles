" Lightline

let g:lightline = {
    \ 'colorscheme': 'challenger_deep',
    \ 'active': {
    \   'left': [['mode', 'paste'],
    \            ['gitinfo', 'readonly', 'filename', 'modified' ] ],
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
    \   'right': [['time']],
    \ },
    \ 'component': {
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \   'separator': '',
    \ },
    \ 'component_function': {
    \   'mode': 'LightlineMode',
    \   'time': 'LightlineTime',
    \   'gitinfo': 'GitInfo',
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
        " TODO fix what ever denite is doing wrong
        return lightline#mode()
        "return 'denite'
    elseif &filetype == 'netrw'
        return 'netrw'
    else
        return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
            \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
            \ &filetype ==# 'defx' ? 'Defx' :
            \ lightline#mode()
    endif
endfunction

function! LightlineTime()
    if has('win64')
        return system('time /t')[:-2]
    else
        return system('date +"%H:%M"')[:-2]
    endif
endfunction

fun! GitInfo()
   let branch = gitbranch#name()
   let l:hunks = GitGutterGetHunkSummary()
   let l:line = branch
   " If we have any hunks, display the number
   " Stolen from vimways article
   if l:hunks[0] || l:hunks[1] || l:hunks[2]
       let l:line .= ' +' . l:hunks[0] .
                  \ ' ~' . l:hunks[1] .
                  \ ' -' . l:hunks[2]
   endif
    return l:line
endf

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

