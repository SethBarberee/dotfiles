set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set number relativenumber " uses the numbertoggle plugin
set confirm            " add a confirmation
set hlsearch	       " switch on highlighting the last used search pattern
set noshowmode         " get rid of the -- INSERT -- at the bottom
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set hidden " allow buffer switching without saving
set mouse=a
set encoding=utf-8
set laststatus=2
set showtabline=2
set backspace=indent,eol,start
syntax on               " turn on syntax
set clipboard+=unnamedplus " set clipboard
set splitbelow
set splitright

" VimPlug plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dylanaraps/wal.vim'
Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep'}
Plug 'itchyny/lightline.vim'
Plug 'taohexxx/lightline-buffer'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
Plug 'sebastianmarkow/deoplete-rust' " completion for rust
Plug 'zchee/deoplete-clang' " completion for c/c++/arduino
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neoinclude.vim' " completion for include files
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'neomake/neomake'
call plug#end()

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif

augroup END

" Line numbers
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif

" Enable true colors if available
if has('termguicolors')
    set termguicolors
endif
" Set colorscheme
colorscheme challenger_deep

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'

" Mappings

let mapleader = ","  " Change leader to comma which is easier to reach
map <C-T> :TagbarOpen j<Enter>

" Use System clipboard
noremap yy "+yy
noremap dd "+dd
noremap p "+gP

noremap <C-c> "+yy
vnoremap <C-c> "+y
noremap <C-x> "+dd
vnoremap <C-x> "+d
map <C-v> "+gP

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Deoplete Settings

let g:deoplete#enable_at_startup = 1
" C/C++ Deoplete and Arduino
call deoplete#custom#source('clang', 'fileytpes', ['c', 'cpp', 'arduino'])
let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang"
" Rust Deoplete
let g:deoplete#sources#rust#racer_binary = '/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path= '/usr/lib/rustlib/src/rust/src'
call neomake#configure#automake('nw', 750)
let g:neomake_open_list = 2 " automatically open neomake list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lightline

let g:lightline = {
    \ 'colorscheme': 'challenger_deep',
    \ 'active': {
    \   'left': [['mode', 'paste'],
    \            ['gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ ['lineinfo'],
    \           ['percent'],
    \           ['tagbar', 'fileencoding', 'filetype']],
    \ },
    \ 'tabline': {
    \   'left': [['bufferinfo'],
    \             [ 'separator' ],
    \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
    \   'right': [['close']]
    \ },
    \ 'component': {
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \   'separator': '',
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name',
    \   'readonly': 'LightlineReadonly',
    \   'bufferinfo': 'lightline#buffer#bufferinfo',
    \ },
    \ 'component_expand': {
    \   'buffercurrent': 'lightline#buffer#buffercurrent',
    \   'bufferbefore': 'lightline#buffer#bufferbefore',
    \   'bufferafter': 'lightline#buffer#bufferafter',
    \ },
    \ 'component_type': {
    \   'buffercurrent': 'tabsel',
    \   'bufferbefore': 'raw',
    \   'bufferafter': 'raw',
    \ }
    \ }

let g:lightline#bufferline#unnamed = '[No Name]'
" Get rid of RO when looking at help pages
function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1

" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'

" hide buffer list
let g:lightline_buffer_excludes = ['vimfiler']

" max file name length
let g:lightline_buffer_maxflen = 30

" max file extension length
let g:lightline_buffer_maxfextlen = 3

" min file name length
let g:lightline_buffer_minflen = 16

" min file extension length
let g:lightline_buffer_minfextlen = 3

" reserve length for other component (e.g. info, close)
let g:lightline_buffer_reservelen = 20
