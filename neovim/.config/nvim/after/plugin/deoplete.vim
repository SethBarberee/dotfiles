" Deoplete Settings

let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})

call deoplete#custom#option('sources', {
		\ '_': ['buffer', 'tag'],
		\ 'cpp': ['buffer', 'tag', 'clangx'],
        \ 'python': ['buffer', 'tag', 'jedi'],
        \ 'disabled_syntaxes': ['Comment', 'String']
		\})

" Deoplete is off initially so start it when entering insert mode
augroup DeopleteToggle 
    autocmd InsertEnter * call deoplete#enable()
    autocmd InsertLeave * call deoplete#disable()
augroup END


" Rust Deoplete
let g:deoplete#sources#rust#racer_binary = '/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path= '/usr/lib/rustlib/src/rust/src'

" Jedi Deoplete
let g:deoplete#sources#jedi#show_docstring = 1

