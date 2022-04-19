if !exists('g:loaded_vim_which_key')
    finish
endif

let g:which_key_use_floating_win = 0
let g:which_key_timeout = 300
let g:which_key_fallback_to_native_key=1 " use native vim commands if key isn't used

" Uncomment to get rid of statusline
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode
  \| autocmd BufLeave <buffer> set laststatus=2 showmode

let g:which_key_map = {}

let g:which_key_map['b'] = {
      \ 'name' : '+buffers' ,
      \ 'l' : ['ls'     , 'list-buffers'],
      \ 'q' : ['bd'     , 'quit-buffer'] ,
      \ }

" Create key in dictionary so we can set g key for highlight groups
let g:which_key_map['h'] = {}

" Use the treesitter impl if we have it
if has_key(plugs, "nvim-treesitter") && has_key(plugs, "playground")
    let g:which_key_map.h.g = [':TSHighlightCapturesUnderCursor', 'highlight-group']
else
    let g:which_key_map.h.g =  [':call SynStack()', 'highlight-group']
endif

" Only define these when we have nvim-lspconfig
if has_key(plugs, "nvim-lspconfig")
" NOTE: v:lua is needed to call the lua funcs
    let g:which_key_map['l'] = {
      \ 'name' : '+lsp' ,
      \ 'c'    : ['v:lua.vim.lsp.buf.code_action()',     'lsp-code_action'],
      \ 'D'    : ['v:lua.vim.lsp.buf.declaration()',     'lsp-declaration'],
      \ 'd'    : ['v:lua.vim.lsp.buf.definition()',      'lsp-definition'],
      \ 'f'    : ['v:lua.vim.lsp.buf.formatting()',      'lsp-formatting'],
      \ 'h'    : ['v:lua.vim.lsp.buf.hover()',           'lsp-hover'],
      \ 'i'    : ['v:lua.vim.lsp.buf.implementation()',  'lsp-implemenation'],
      \ '<c-k>': ['v:lua.vim.lsp.buf.signature_help()',  'lsp-sighelp'],
      \ 't'   : ['v:lua.vim.lsp.buf.type_definition()', 'lsp-typedef'],
      \ 'r'    : ['v:lua.vim.lsp.buf.references()',      'lsp-references'],
      \ 'R'    : ['v:lua.vim.lsp.buf.rename()',      'lsp-rename'],
      \ '0'    : ['v:lua.vim.lsp.buf.document_symbol()', 'lsp-docsymbol'],
      \ 'W'    : ['v:lua.vim.lsp.buf.workspace_symbol()','lsp-workspacesymbol'],
      \ }

endif



let g:which_key_map.d = { 'name' : '+denite'}

let g:which_key_map.g = { 'name' : '+Git'}

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :WhichKey ','<CR>
