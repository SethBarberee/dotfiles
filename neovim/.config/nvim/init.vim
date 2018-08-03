if has('nvim')
    let s:editor_root=expand("~/.nvim")
else
    let s:editor_root=expand("~/.vim")
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/denite.nvim'
Plug 'zchee/deoplete-clang'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'bling/vim-bufferline'
Plug 'neomake/neomake' "maybe look at ALE??
call plug#end()

" Always display airline
set laststatus=2
" For indents that consist of 4 space characters but are entered with the tab key
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set encoding=utf-8
set noswapfile
colorscheme base16-onedark
let g:airline_detect_modified=1
let g:airline_detect_spell=1
let g:airline_detect_paste=1
let g:airline_inactive_collapse=1
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts=1
let g:airline_theme = "base16_colors"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:bufferline_echo = 0

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang"

call neomake#configure#automake('nw', 750)
let g:neomake_open_list = 2 " automatically open neomake list
