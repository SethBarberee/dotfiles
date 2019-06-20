
if !exists(':Gdiff')
    finish
endif

nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
