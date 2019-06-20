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
    \   'left': [['buffers']],
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
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers',
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel',
    \ }
    \ }

function! LightlineMode() abort
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

function! LightlineTime() abort
    if has('win64')
        return system('time /t')[:-2]
    else
        return system('date +"%H:%M"')[:-2]
    endif
endfunction

fun! GitInfo() abort
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

" Get rid of RO when looking at help pages
function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

" Add a devicon with the filetype
function! MyFiletype()
     return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : '' 
endfunction
