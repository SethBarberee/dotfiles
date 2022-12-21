return {

    -- Looks/UI

    -- TODO: port local challenger-deep lua theme to plugin..
    { "challenger-deep-theme/vim", name = "challenger-deep" },
    'nvim-lua/plenary.nvim',
    'nvim-lualine/lualine.nvim', -- statusline
    'edkolev/tmuxline.vim', -- tmux statusline based on statusline
    'lukas-reineke/indent-blankline.nvim',
    'rrethy/vim-illuminate',
    'nvim-tree/nvim-web-devicons',
    'folke/lazy.nvim',

    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim', -- for neotree
        },
    },

    -- Better folding (using LSP and treesitter)
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async',
        },
    },

    'simrat39/rust-tools.nvim',

    -- Nvim DAP
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'mfussenegger/nvim-dap-python',
            'theHamsta/nvim-dap-virtual-text',
            'rcarriga/nvim-dap-ui',
            'nvim-telescope/telescope-dap.nvim',
            'jbyuki/one-small-step-for-vimkind',
        }
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-ui-select.nvim',
            'benfowler/telescope-luasnip.nvim',
        }
    },

    'folke/which-key.nvim',
    'rrethy/vim-hexokinase',

    -- Utils
    'airblade/vim-rooter', -- auto cd to base dir of project
    'numToStr/Comment.nvim',

    -- Tags
    'ludovicchabant/vim-gutentags', --tag management
    'liuchengxu/vista.vim',

    -- Git
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        }
    },

    'sgur/vim-editorconfig', -- to honor editorconfig

    -- Markdown Rendering
    { 'iamcco/markdown-preview.nvim', ft = "markdown" },

    -- Treesitter Plugins
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'JoosepAlviste/nvim-ts-context-commentstring',
            'SmiteshP/nvim-gps',
        }
    },

    -- LSP Plugins
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'glepnir/lspsaga.nvim',
            "j-hui/fidget.nvim", -- Lsp status notifications
            'SmiteshP/nvim-navic',
        }
    },
    'jose-elias-alvarez/null-ls.nvim',


    -- NVIM cmp / autocomplete
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'quangnguyen30192/cmp-nvim-tags',
            'saadparwaiz1/cmp_luasnip',
        }
    },
    'ii14/emmylua-nvim',
    'onsails/lspkind.nvim',
}
