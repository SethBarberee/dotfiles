# Neovim Config

## Plugin List

```
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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
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
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
```

* Did this with a simple `read | grep "Plug '*'" init.vim
