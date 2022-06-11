# Neovim Config
```
    " Looks/UI
    Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep'}

    Plug 'itchyny/lightline.vim'
    Plug 'edkolev/tmuxline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'thaerkh/vim-indentguides'
    Plug 'bfrg/vim-cpp-modern' " enhanced C and C++ highlighting
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
    Plug 'liuchengxu/vim-which-key'
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

if has('nvim')
    " Deoplete and sources
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

    " Enable LSP/Treesitter plugins
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'SmiteshP/nvim-gps'
    Plug 'neovim/nvim-lspconfig'
    Plug 'deoplete-plugins/deoplete-lsp'
else
    " Allow Denite/Deoplete to run on vim
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
end

    " Deoplete addons
    Plug 'Shougo/neoinclude.vim' " completion for include files
    Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
    Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'} " completion for rust
    Plug 'deoplete-plugins/deoplete-clang', { 'for': ['c', 'cpp', 'arduino'] } " completion for c/c++/arduino
    Plug 'deoplete-plugins/deoplete-tag'
    Plug 'deathlyfrantic/deoplete-spell' " spelling check source
    Plug 'Shougo/neco-syntax'
    Plug 'Shougo/neco-vim', {'for': 'vim'}
```

Pulled from `plugins.vim`

## Optional Dependencies

* `rg` - enhanced search (in `denite`)
