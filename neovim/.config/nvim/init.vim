"
"            _           
" _ ____   _(_)_ __ ___  
"| '_ \ \ / / | '_ ` _ \ 
"| | | \ V /| | | | | | |
"|_| |_|\_/ |_|_| |_| |_|
                        
set ruler              " show the cursor position all the time
set title
set showcmd            " display incomplete commands
set number relativenumber " uses the numbertoggle plugin
set confirm            " add a confirmation
set hlsearch	       " switch on highlighting the last used search pattern
set noshowmode         " get rid of the -- INSERT -- at the bottom
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set ignorecase
set smartcase
set noswapfile
set hidden " allow buffer switching without saving
set mouse=a
set encoding=UTF-8
set laststatus=2
set showtabline=2
set backspace=indent,eol,start
syntax on               " turn on syntax
set clipboard+=unnamedplus " set clipboard
set splitbelow
set splitright
set lazyredraw
set shortmess=FaWc " see :help shortmess
set guioptions=M "diable GUI menus... I don't need them

" Check if VimPlug exists. If not, download it
if empty("~/.local/share/nvim/plugged")
     silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" VimPlug plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dylanaraps/wal.vim'
Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep'}
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'taohexxx/lightline-buffer'
Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}
Plug 'ludovicchabant/vim-gutentags' "tag management
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'} " completion for rust
Plug 'Shougo/deoplete-clangx', { 'for': ['c', 'cpp', 'arduino'] } " completion for c/c++/arduino
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'Shougo/denite.nvim'
Plug 'Shougo/defx.nvim', {'on': 'Defx'}
Plug 'kristijanhusak/defx-git' " git icons for defx
Plug 'kristijanhusak/defx-icons' " file icons for defx
Plug 'Shougo/neoinclude.vim' " completion for include files
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " TODO look at ale
Plug 'neomake/neomake'
Plug 'ryanoasis/vim-devicons'
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

  " Close any automatically opened scratch-buffers 
  " " once completion popup the is closed
  autocmd CompleteDone * pclose

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
map <C-T> :TagbarOpenAutoClose <Enter>
"map <C-D> :Defx -columns=git:icons:filename:type <Enter>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Deoplete Settings

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
		\ '_': ['buffer', 'tag'],
		\ 'cpp': ['buffer', 'tag'],
        \ 'disabled_syntaxes': ['Comment', 'String']
		\})
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
    \ 'inactive' : {
    \   'left': [['filename']],
    \   'right': [[ 'lineinfo'], [ 'percent']]
    \ },
    \ 'tabline': {
    \   'left': [['bufferinfo'],
    \             [ 'separator' ],
    \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
    \ },
    \ 'component': {
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \   'separator': '',
    \ },
    \ 'component_function': {
    \   'mode': 'LightlineMode',
    \   'gitbranch': 'gitbranch#name',
    \   'readonly': 'LightlineReadonly',
    \   'filetype': 'MyFiletype',
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

function! LightlineMode()
    let fname = expand('%:t')
    if &ft == 'denite'
        let mode_str = substitute(denite#get_status_mode(), "-\\| ", "", "g")
        call lightline#link(tolower(mode_str[0]))
        return mode_str
    else
        return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
            \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
            \ &filetype ==# 'defx' ? 'Defx' :
            \ lightline#mode()
endfunction

let g:lightline#bufferline#unnamed = '[No Name]'

" Get rid of RO when looking at help pages
function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

" Add a devicon with the filetype
function! MyFiletype()
     return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : '' 
endfunction

" whether to show the buffer number of not
let g:lightline_buffer_show_bufnr = 0

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

" enable devicons in lightline buffer
let g:lightline_buffer_enable_devicons = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar config
let g:tagbar_autoclose = 1
let g:tagbar_expand = 1 " what does this do?
let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
		  return lightline#statusline(0)
endfunction

" Devicon config
let g:webdevicons_enable_denite = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
