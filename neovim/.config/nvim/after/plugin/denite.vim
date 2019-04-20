if !exists(':Denite')
    finish
endif

" Denite config
" I should explain some of this stuff
" Custom prompt of >
" Denite statusline is disabled to use lightline
" I like the insert highlight mode of WildMenu
" Auto resizes as you narrow down results
call denite#custom#option('default', {
            \ 'prompt': '>',
            \ 'auto_resize': v:true,
            \ 'statusline': v:false,
            \ 'highlight_mode_insert': 'WildMenu',
            \ })

" Ignoring a lot of pointless stuff that ends up in my directories
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
       \ [ '.git/', '.ropeproject/', '__pycache__/*', '*.pyc',
       \ 'venv/', 'images/', '*.min.*', 'img/', 'fonts/', '*.o', 'tags',
       \ '*.png'])

nnoremap <space>s :Denite file -auto-preview<cr>
nnoremap <space>l :Denite line -auto-preview<cr>
