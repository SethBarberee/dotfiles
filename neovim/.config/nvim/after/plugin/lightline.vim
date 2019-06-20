" Lightline

let g:lightline = {
    \ 'colorscheme': 'challenger_deep',
    \ 'active': {
    \   'left': [['mode', 'paste'],
    \            ['gitinfo', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ ['lineinfo'],
    \           ['percent'],
    \           ['tag', 'fileencoding', 'filetype']],
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
    \   'separator': '',
    \ },
    \ 'component_function': {
    \   'mode': 'LightlineMode',
    \   'time': 'LightlineTime',
    \   'gitinfo': 'GitInfo',
    \   'readonly': 'LightlineReadonly',
    \   'filetype': 'MyFiletype',
    \   'tag':  'LightlineTag',
    \   'filename': 'LightlineFilename',
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers',
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel',
    \ }
    \ }

fun! LightlineTag() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endf

fun! LightlineFilename() abort
    let fname = expand('%:t')
    if fname ==# '__vista__'
        " Get rid of name
        return "Tags"
    else
        return fname
    endif
endf

function! LightlineMode() abort
    let fname = expand('%:t')
    if &filetype == 'netrw'
        return 'netrw'
    else
        return fname  ==# '__Tagbar__' ? 'Tagbar':
            \ fname ==# '__vista__' ? 'Vista':
            \ fname ==# 'ControlP' ? 'CtrlP':
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

" Get rid of RO when looking at help pages and in Vista
function! LightlineReadonly()
    let fname = expand('%:t')
    return &readonly && &filetype !=# 'help'  &&  fname !=# '__vista__' ? 'RO' : ''
endfunction

" Add a devicon with the filetype
function! MyFiletype()
     return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : '' 
endfunction
