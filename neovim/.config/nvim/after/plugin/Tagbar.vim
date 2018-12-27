if !exists(':Tagbar')
    finish
endif

" Tagbar config
let g:tagbar_autoclose = 1
let g:tagbar_expand = 1 " what does this do?
let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
		  return lightline#statusline(0)
endfunction

map <C-T> :TagbarOpenAutoClose <Enter>


