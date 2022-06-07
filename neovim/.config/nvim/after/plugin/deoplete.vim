" Deoplete Settings

if !exists('g:loaded_deoplete')
    finish
endif

call deoplete#custom#option('min_patern_length', 1)

" maximum candidate window length
" TODO play with this
"call deoplete#custom#source('_', 'max_menu_width', 80)

call deoplete#custom#option('sources', {
            \ '_': ['ultisnips', 'tag', 'lsp'],
            \ 'markdown': ['ultisnips', 'spell'],
            \ 'cpp': ['ultisnips', 'tag', 'clang', 'lsp'],
            \ 'python': ['ultisnips', 'tag', 'jedi','lsp'],
            \ 'disabled_syntaxes': ['Comment', 'String']
            \})

" Deoplete is off initially so start it when entering insert mode
augroup DeopleteToggle 
    autocmd InsertEnter * call deoplete#enable()
    autocmd InsertLeave * call deoplete#disable()
augroup END

" Clang Deoplete
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

" Rust Deoplete
let g:deoplete#sources#rust#racer_binary = '/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path= '/usr/lib/rustlib/src/rust/src'

" Jedi Deoplete
let g:deoplete#sources#jedi#show_docstring = 1

" LSP Deoplete
let g:deoplete#lsp#use_icons_for_candidates = v:true

" Snippets
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#source('ultisnips', 'min_pattern_length', 1)
