if !exists('g:loaded_lightline')
    finish
endif

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
    let fname = expand('%:t')
    if &filetype ==# 'netrw'
        return ''
    endif

    if has('nvim')
        " Use the following order to figure out where we are:
        " navic -> gps -> vista
        "
        " NOTE: python lsp still doesn't support documentSymbol so have this
        " check to force nvim-gps
        if luaeval("require'nvim-navic'.is_available()") && &filetype !=# 'python'
            return luaeval("require'nvim-navic'.get_location()")
        elseif luaeval("require'nvim-gps'.is_available()")
                return luaeval("require'nvim-gps'.get_location()")
        else
            return get(b:, 'vista_nearest_method_or_function', '')
        endif
    endif

    return get(b:, 'vista_nearest_method_or_function', '')
endf

" Update Function
augroup lightline_startup
    autocmd VimEnter * call LightlineTag()
    if has('nvim-0.8')
        autocmd BufEnter * SatelliteEnable
    endif
augroup end

fun! LightlineFilename() abort
    let fname = expand('%:t')
    return fname ==# '__vista__' ? 'Tags' :
        \ fname ==# 'NetrwTreeListing' ? 'Netrw' :
        \ fname
endf

function! LightlineMode() abort
    let fname = expand('%:t')
    return &filetype ==# 'netrw' ? '' :
            \ &filetype ==# 'help' ? 'HELP' :
            \ &filetype ==# 'tsplayground' ? 'Treesitter' :
            \ fname  ==# '__Tagbar__' ? 'Tagbar':
            \ fname ==# '__vista__' ? 'Vista':
            \ fname ==# 'ControlP' ? 'CtrlP':
            \ lightline#mode()
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
    " Don't show GitInfo on netrw/help/denite/vista
    if &filetype ==# 'netrw' || &filetype ==# 'help' || &filetype ==# 'denite' || &filetype ==# 'denite-filter' || &filetype ==# 'vista' || &filetype ==# 'tsplayground'
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
    if &filetype ==# 'denite' || &filetype ==# 'help' || &filetype ==# 'denite-filter' || &filetype ==# 'tsplayground'
        return ''
    endif
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : '' 
endfunction

" Return the encodings
function! LightlineFileencoding()
    if &filetype ==# 'help'
        return ''
    endif
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
