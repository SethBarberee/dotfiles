# Neovim Config

```
Plug 'lewis6991/impatient.nvim'

-- Looks/UI

-- TODO: port local challenger-deep lua theme to plugin..
Plug('challenger-deep-theme/vim', { as = 'challenger-deep' })
Plug 'lewis6991/satellite.nvim' -- add Scrollbar to side of NVIM
Plug 'j-hui/fidget.nvim' -- Lsp status notifications
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'edkolev/tmuxline.vim'
Plug 'thaerkh/vim-indentguides'

Plug 'bfrg/vim-cpp-modern' -- enhanced C and C++ highlighting
Plug 'simrat39/rust-tools.nvim'

-- Nvim DAP
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'jbyuki/one-small-step-for-vimkind'

-- Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'

Plug 'folke/which-key.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug('rrethy/vim-hexokinase', { ['do'] = vim.fn['make hexokinase'] }) -- TODO check out nvim-colorizer

-- Utils
Plug 'airblade/vim-rooter' -- auto cd to base dir of project

-- Tags
Plug 'ludovicchabant/vim-gutentags' --tag management
Plug 'liuchengxu/vista.vim'

-- Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

-- Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'sgur/vim-editorconfig' -- to honor editorconfig

-- Markdown Rendering
Plug('iamcco/markdown-preview.nvim', { ['do'] = vim.fn['cd app & yarn install'], ['for'] = 'markdown' })

-- Treesitter Plugins
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn[':TSUpdate'] })
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'SmiteshP/nvim-gps'
Plug 'lukas-reineke/indent-blankline.nvim'

-- LSP Plugins
Plug 'SmiteshP/nvim-navic'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'glepnir/lspsaga.nvim'

-- NVIM cmp / autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'quangnguyen30192/cmp-nvim-tags'
Plug 'onsails/lspkind.nvim'
```

Pulled from `lua/seth/plugins.vim`

## Optional Dependencies

* `rg` - enhanced search (in `telescope`)
