# Neovim Config
```
    " Looks/UI
    Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep'}
    Plug 'itchyny/lightline.vim'
    Plug 'edkolev/tmuxline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'thaerkh/vim-indentguides'
    Plug 'bfrg/vim-cpp-modern' " enhanced C and C++ highlighting

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
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " TODO check out nvim-colorizer
    Plug 'ryanoasis/vim-devicons'

    " Markdown Rendering
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown'  }

if has('nvim')
    Plug 'Shougo/denite.nvim'
    " Deoplete and sources
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
else
    " Allow Denite/Deoplete to run on vim
    Plug 'Shougo/denite.nvim'
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
end

    Plug 'Shougo/neoinclude.vim' " completion for include files
    Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
    Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'} " completion for rust
    Plug 'deoplete-plugins/deoplete-clang', { 'for': ['c', 'cpp', 'arduino'] } " completion for c/c++/arduino
    Plug 'deoplete-plugins/deoplete-tag'
    Plug 'deoplete-plugins/deoplete-lsp'
    Plug 'Shougo/neco-syntax'
    Plug 'Shougo/neco-vim', {'for': 'vim'}
```

Pulled from `plugins.vim`

## Optional Dependencies

* `rg` - enhanced search (in `denite`)
