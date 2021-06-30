if !exists(':Denite')
    finish
endif

" Denite config
" I should explain some of this stuff
" Denite statusline is disabled to use lightline
" Auto resizes as you narrow down results
call denite#custom#option('_', {
            \ 'auto_resize': v:true,
            \ 'statusline': v:false,
            \ 'smartcase': v:true,
            \ })

" Ignoring a lot of pointless stuff that ends up in my directories
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
       \ [ '.git/', '.ropeproject/', '__pycache__/*', '*.pyc',
       \ 'venv/', 'images/', '*.min.*', 'img/', 'fonts/', '*.o', 'tags',
       \ '*.png'])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" For ripgrep
" Note: Checks if we have it and sets it
if executable("rg")
    call denite#custom#var('file/rec', 'command',
            \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])
    call denite#custom#var('grep', {
                \ 'command': ['rg'],
                \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
                \ 'recursive_opts': [],
                \ 'pattern_opt': ['--regexp'],
                \ 'separator': ['--'],
                \ 'final_opts': [],
                \ })
endif

" Add custom menus
let s:menus = {}

let s:menus.nvim = {
            \ 'description': 'Edit NVIM config'
            \ }
let s:menus.nvim.file_candidates = [
            \ ['init', '~/.config/nvim/init.vim'],
            \ ['plugins', '~/.config/nvim/plugins.vim'],
            \ ['mappings', '~/.config/nvim/mappings.vim'],
            \ ]


"let s:menus.my_commands = {
"            \ 'description': 'Example commands'
"            \ }
"let s:menus.my_commands.command_candidates = [
"            \ ['Open nvim menu', 'Denite menu:nvim'],
"            \ ]

call denite#custom#var('menu', 'menus', s:menus)


" Custom function to see if we have webicons or not
function! WebIconTest()
    try
        call webdevicons#version()
        " if we make it here, we have icons
        return 1
    catch
        " We don't have icons then
        return 0
    endtry
endfunction
" vim-devicons Issue #265 (account for new denite format)
if(WebIconTest())
    call denite#custom#source('file,file/rec,file/mru,file/old,file/point', 'converters', ['devicons_denite_converter'])
endif

nnoremap <space>s :Denite file <cr>
nnoremap <space>l :Denite line <cr>
nnoremap <space>m :Denite menu <cr>
nnoremap <space>g :Denite grep <cr>

autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
        \ denite#do_map('toggle_select').'j'
        nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
    endfunction
