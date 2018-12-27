" Deoplete Settings

let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})

call deoplete#custom#option('sources', {
		\ '_': ['buffer', 'tag'],
		\ 'cpp': ['buffer', 'tag'],
        \ 'python': ['buffer', 'tag', 'jedi'],
        \ 'disabled_syntaxes': ['Comment', 'String']
		\})
call deoplete#custom#option('omni_patterns', {
        \ 'complete_method': 'omnifunc',
        \ 'terraform': '[^ *\t"{=$]\w*',
        \})

" Rust Deoplete
let g:deoplete#sources#rust#racer_binary = '/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path= '/usr/lib/rustlib/src/rust/src'

" Jedi Deoplete
let g:deoplete#sources#jedi#show_docstring = 1

