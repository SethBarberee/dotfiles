"""""""""""""""""""""""""""""""""""
" Vim Plug Settings
" Check if VimPlug exists. If not, download it

" NOTE:  Defaults to ~/.config/nvim/autoload/plug.vim on Linux
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'

if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

" VimPlug plugins
call plug#begin('~/.local/share/nvim/plugged')

" Check if we have plugins installed and install if we don't
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    autocmd VimEnter * PlugInstall | q
endif

    Plug 'lewis6991/impatient.nvim'

    " Looks/UI
    Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep'}
    Plug 'lewis6991/satellite.nvim' " add Scrollbar to side of NVIM
    Plug 'j-hui/fidget.nvim' " Lsp status notifications
    Plug 'nvim-lua/plenary.nvim'

    Plug 'itchyny/lightline.vim'
    Plug 'edkolev/tmuxline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'thaerkh/vim-indentguides'
    Plug 'bfrg/vim-cpp-modern' " enhanced C and C++ highlighting
    "Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'folke/which-key.nvim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " TODO check out nvim-colorizer

    " Utils
    Plug 'airblade/vim-rooter' " auto cd to base dir of project

    " Tags
    Plug 'ludovicchabant/vim-gutentags' "tag management
    Plug 'liuchengxu/vista.vim'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Snippets
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    Plug 'sgur/vim-editorconfig' " to honor editorconfig

    " Markdown Rendering
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown'  }

    " Denite
    Plug 'Shougo/denite.nvim'

    " Treesitter Plugins
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'SmiteshP/nvim-gps'
    Plug 'lukas-reineke/indent-blankline.nvim'

    " LSP Plugins
    Plug 'SmiteshP/nvim-navic'
    Plug 'neovim/nvim-lspconfig'
    Plug 'jose-elias-alvarez/null-ls.nvim'

    " NVIM cmp / autocomplete
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    Plug 'quangnguyen30192/cmp-nvim-tags'
    Plug 'onsails/lspkind.nvim'

    " Lua NVIM
    Plug 'folke/lua-dev.nvim' " some more completion stuff for nvim lua LSP

call plug#end()

set completeopt=menu,menuone,noselect " for nvim-cmp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Devicon config
if has_key(plugs, 'vim-devicons') && has_key(plugs, 'denite.nvim')
    let g:webdevicons_enable_denite = 1
endif

" Hexokinase settings since a seperate file doesn't work
if has_key(plugs, 'vim-hexokinase')
    let g:Hexokinase_ftAutoload = ['*']
    let g:Hexokinase_highlighters = ['backgroundfull']
endif

" These lightline settings can't be moved...
if has_key(plugs, 'lightline.vim')
    let g:lightline#bufferline#unnamed = '[No Name]'
    let g:lightline#bufferline#show_number=2
    let g:lightline#bufferline#enable_devicons=1 " until i'm using a decent font
    let g:lightline#bufferline#filename_modifier=':t' " only show basefile and extension
endif

let g:clap_no_matches_msg = 'OOPSIE WOOPSIE NO MATCHES FOR YOU'

" Load our lua plugin config files
lua require('lsp')
lua require("treesitter")
lua require("which_key")
lua require('fidget').setup()
if has('nvim-0.8')
    lua require('satellite').setup()
endif
lua require('telescope').setup()
