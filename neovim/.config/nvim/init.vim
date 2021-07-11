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
set timeoutlen=300     " don't wait as long for timeout (mainly for which-key)

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
syntax on
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

let g:vimpath = fnamemodify(expand("$MYVIMRC"), ":p:h")

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

augroup rasi_css
    " set rasi filetypes to css
    autocmd BufRead,BufNewFile /*.rasi setf css
augroup end

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

" Load plugins and mappings
exec "source "  . g:vimpath . "/plugins.vim"
exec "source "  . g:vimpath . "/mappings.vim"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme

" Enable true colors if available
if has('termguicolors')
    set termguicolors
endif

" Set colorscheme
colorscheme challenger_deep
if g:colors_name ==# 'challenger_deep'
    " These overrides were taken from https://github.com/skbolton/titan/blob/master/states/nvim/nvim/plugin/themes.vim
    hi DiffAdd guibg=#62d196 guifg=black
    hi DiffDelete guibg=#ff5458 guifg=black
    hi DiffChange guibg=#ffb378 guifg=black
    hi DiffText guibg=#ffe9aa guifg=black
    let g:challenger_deep_terminal_italics = 1
endif

let s:default_path = escape(&path, '\ ') " store default value of 'path'

" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
autocmd BufRead *
      \ let s:tempPath=finddir('.git/..', expand('%:p:h').';') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path

"" TODO figure out how to move this
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

let g:gutentags_cache_dir = expand('~/cache/vim/ctags/')

" a -> acccess or export of class members
" i -> inheritance information
" l -> language of input file containing tag
" m -> implementation information
" n -> line number of tag definition
" S -> Signature of routine (prototype or parameter list)

let g:gutentags_ctags_extra_args = [
    \ '--tag-relative=yes',
    \ '--fields=+ailmnS',
    \ ]

