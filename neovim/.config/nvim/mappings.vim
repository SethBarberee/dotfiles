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

" https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
function! SynStack()
  if !exists("*synstack")
    return
  endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
