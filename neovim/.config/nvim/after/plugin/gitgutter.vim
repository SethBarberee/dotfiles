if !exists(':GitGutter')
    finish
endif

set updatetime=100 " change this for more responsive signs

" Jump between hunks
nmap <leader>gn <Plug>GitGutterNextHunk
nmap <leader>gp <Plug>GitGutterPrevHunk
