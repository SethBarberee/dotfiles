" Mappings

let mapleader = "\<Space>"  " Change leader to space which is easier to reach
let maplocalleader = ','  " Change localleader to ,

" No need for ex mode
nnoremap Q <nop>
" recording macros is not my thing
map q <Nop>


" Use System clipboard
noremap yy "+yy
noremap dd "+dd
noremap p "+gP

noremap <C-c> "+yy
vnoremap <C-c> "+y
noremap <C-x> "+dd
vnoremap <C-x> "+d
"map <C-v> "+gP

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nnoremap <Right> :bnext<CR>

" Move to the previous buffer
nnoremap <Left> :bprev<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
function! SynStack()
  if !exists("*synstack")
    return
  endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Use the treesitter impl if we have it
if has_key(plugs, "nvim-treesitter") && has_key(plugs, "playground")
    nnoremap <Leader>hg :TSHighlightCapturesUnderCursor<CR>
else
    nnoremap <Leader>hg :call SynStack()<CR>
endif

if has_key(plugs, "nvim-lspconfig")
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
endif
