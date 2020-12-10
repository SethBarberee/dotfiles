" Mappings

let mapleader = ','  " Change leader to comma which is easier to reach

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
nmap <leader>l :bnext<CR>
nnoremap <Right> :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>
nnoremap <Left> :bprev<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Automatically add a closing parentheses/brace when typing the opening 
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
