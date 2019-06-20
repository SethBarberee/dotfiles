"
"            _           
" _ ____   _(_)_ __ ___  
"| '_ \ \ / / | '_ ` _ \ 
"| | | \ V /| | | | | | |
"|_| |_|\_/ |_|_| |_| |_|
                        
set ruler              " show the cursor position all the time
set cursorline         " indicate which line the curosr is on
set title
set showcmd            " display incomplete commands
set number
set confirm            " add a confirmation
set ignorecase
set smartcase
set hlsearch	       " switch on highlighting the last used search pattern
set noshowmode         " get rid of the -- INSERT -- at the bottom

"""""""""""""""""""
" Indent Settings "
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

"""""""""""""""""""
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

""""""""""""""""""""""
" Fold Settings "
set foldmethod=syntax "syntax folds
set foldcolumn=1 " define 1 col at window left to indicate folding
set foldlevelstart=99 "start with all folds opened
"""""""""""""""""""""""

if has('gui_running')
    set guioptions=M "diable GUI menus... I don't need them
endif

if has('nvim')
    let g:python_host_prog = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'
endif

"""""""""""""""""""""""""""""""""""
" Vim Plug Settings
" Check if VimPlug exists. If not, download it
if empty('~/.local/share/nvim/plugged')
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" VimPlug plugins
call plug#begin('~/.local/share/nvim/plugged')

" Check if we have plugins installed and install if we don't
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    autocmd VimEnter * PlugInstall | q
endif

Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep'}
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'thaerkh/vim-indentguides'
Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}
Plug 'ludovicchabant/vim-gutentags' "tag management
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Deoplete and sources
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'} " completion for rust
Plug 'deoplete-plugins/deoplete-clang', { 'for': ['c', 'cpp', 'arduino'] } " completion for c/c++/arduino
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'Shougo/denite.nvim'
Plug 'Shougo/defx.nvim', {'on': 'Defx'}
Plug 'kristijanhusak/defx-git' " git icons for defx
Plug 'kristijanhusak/defx-icons' " file icons for defx
Plug 'Shougo/neoinclude.vim' " completion for include files
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " TODO look at ale
Plug 'sgur/vim-editorconfig' " to honor editorconfig
Plug 'RRethy/vim-hexokinase'
Plug 'ryanoasis/vim-devicons'
Plug 'neomake/neomake', {'on': []} " just disable neomake for now
" Markdown Rendering
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
    autocmd!

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
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber number
augroup END


" Better diff (https://vimways.org/2018/the-power-of-diff)
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(':DiffOrig')
    command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme

" Enable true colors if available
if has('termguicolors')
    set termguicolors
endif

" Set colorscheme
colorscheme challenger_deep

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Devicon config
let g:webdevicons_enable_denite = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Hexokinase settings since a seperate file doesn't work
let g:Hexokinase_ftAutoload = ['*']

let g:Hexokinase_highlighters = ['virtual']

let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#show_number=2
let g:lightline#bufferline#enable_devicons=0 " until i'm using a decent font
let g:lightline#bufferline#filename_modifier=':t' " only show basefile and extension

