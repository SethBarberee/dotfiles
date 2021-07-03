
if !exists('g:loaded_fugitive')
    finish
endif

nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Gdiff<CR>
