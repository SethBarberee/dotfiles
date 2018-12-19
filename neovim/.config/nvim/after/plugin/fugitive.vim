" Kind of a hack to lazy load fugitive but it works
" https://github.com/junegunn/vim-plug/issues/164

command! Gstatus call LazyLoadFugitive('Gstatus')
command! Gdiff call LazyLoadFugitive('Gdiff')
command! Glog call LazyLoadFugitive('Glog')
command! Gblame call LazyLoadFugitive('Gblame')
command! Gwrite call LazyLoadFugitive('Gwrite')

function! LazyLoadFugitive(cmd)
  call plug#load('vim-fugitive')
  call fugitive#detect(expand('%:p'))
  exe a:cmd
endfunction
