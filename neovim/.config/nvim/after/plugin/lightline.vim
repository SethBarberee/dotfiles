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
    \   'fileencoding': 'LightlineFileencoding',
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

" Update Function 
augroup lightline_startup
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
augroup end

fun! LightlineFilename() abort
    let fname = expand('%:t')
    if fname ==# '__vista__'
        " Get rid of name
        return 'Tags'
    endif
    if fname ==# 'NetrwTreeListing'
        return 'Netrw'
    "else
    endif
    return fname
endf

function! LightlineMode() abort
    let fname = expand('%:t')
    if &filetype == 'netrw'
        return ''
    else
        return fname  ==# '__Tagbar__' ? 'Tagbar':
            \ fname ==# '__vista__' ? 'Vista':
            \ fname ==# 'ControlP' ? 'CtrlP':
            \ &filetype ==# 'chadtree' ? 'CHADTree' :
            \ lightline#mode()
    endif
endfunction

" Get the time
function! LightlineTime() abort
    if has('win64')
        return system('time /t')[:-2]
    else
        return system('date +"%H:%M"')[:-2]
    endif
endfunction

fun! GitInfo() abort
    " Don't show GitInfo on netrw or help
    if &filetype == 'netrw' || &filetype == 'help'
        return ''
    endif
    let branch = FugitiveHead()
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
    return &readonly && &filetype !~# '\v(help|vista|chadtree|netrw)'  ? 'RO' : ''
endfunction

" Add a devicon with the filetype
function! MyFiletype()
     return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : '' 
endfunction

" Return the encodings
function! LightlineFileencoding()
    return winwidth(0) > 70 ? &fileencoding : ''
endfunction

" Simple mappings to switch buffers
nmap 1 <Plug>lightline#bufferline#go(1)
nmap 2 <Plug>lightline#bufferline#go(2)
nmap 3 <Plug>lightline#bufferline#go(3)
nmap 4 <Plug>lightline#bufferline#go(4)
nmap 5 <Plug>lightline#bufferline#go(5)
nmap 6 <Plug>lightline#bufferline#go(6)
nmap 7 <Plug>lightline#bufferline#go(7)
nmap 8 <Plug>lightline#bufferline#go(8)
nmap 9 <Plug>lightline#bufferline#go(9)
nmap 0 <Plug>lightline#bufferline#go(10)
