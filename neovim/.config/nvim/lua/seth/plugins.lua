return {

    -- Looks/UI
    {
        "SethBarberee/challenger-deep.nvim",
        priority = 1000,
        dev = true,
        config = function()
            vim.cmd.colorscheme("challenger-deep")
        end
    },
    { 'wadackel/vim-dogrun',   event = "VeryLazy" },
    { 'oxfist/night-owl.nvim', event = "VeryLazy" },
    {
        'm-demare/hlargs.nvim',
        opts = {
            color = "#95ffa4",
            hl_priority = 10000,
        },
        event = "VeryLazy",
    },

    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    'folke/lazy.nvim',
    { 'folke/todo-comments.nvim',    dependencies = 'nvim-lua/plenary.nvim', config = true },

    -- Utils
    { 'notjedi/nvim-rooter.lua',     config = true }, -- auto cd to base dir of project
    'fladson/vim-kitty',

    -- Tags
    {
        'ludovicchabant/vim-gutentags',
        config = function()
            vim.g.gutentags_ctags_exclude = {
                '*.git', '*.svg', '*.hg',
                '*/tests/*',
                'build',
                'dist',
                '*sites/*/files/*',
                'bin',
                'node_modules',
                'bower_components',
                'cache',
                'compiled',
                'docs',
                'example',
                'bundle',
                'vendor',
                '*.md',
                '*-lock.json',
                '*.lock',
                '*bundle*.js',
                '*build*.js',
                '.*rc*',
                '*.json',
                '*.min.*',
                '*.map',
                '*.bak',
                '*.zip',
                '*.pyc',
                '*.class',
                '*.sln',
                '*.Master',
                '*.csproj',
                '*.tmp',
                '*.csproj.user',
                '*.cache',
                '*.ccls-cache',
                '*.pdb',
                'tags*',
                'cscope.*',
                '*.css',
                '*.less',
                '*.scss',
                '*.exe', '*.dll',
                '*.mp3', '*.ogg', '*.flac',
                '*.swp', '*.swo',
                '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
                '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
                '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
            }

            --vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/vim/ctags/')

            --
            --" a -> acccess or export of class members
            --" i -> inheritance information
            --" l -> language of input file containing tag
            --" m -> implementation information
            --" n -> line number of tag definition
            --" S -> Signature of routine (prototype or parameter list)
            --
            vim.g.gutentags_ctags_extra_args = {
                '--tag-relative=yes',
                '--fields=+ailmnS',
            }
        end
    }, --tag management
    { 'liuchengxu/vista.vim',     cmd = "Vista" },

    { 'dstein64/vim-startuptime', cmd = "StartupTime" },

    -- Git
    'tpope/vim-fugitive',

    -- Snippets
    {
        'mireq/luasnip-snippets',
        dependencies = { 'L3MON4D3/LuaSnip' },
        init = function()
            -- Mandatory setup function
            require('luasnip_snippets.common.snip_utils').setup()
        end

    },
    {
        'L3MON4D3/LuaSnip',
        event  = "InsertEnter",
        config = function()
            require("luasnip").setup({
                load_ft_func = require('luasnip_snippets.common.snip_utils').load_ft_func,
                ft_func = require('luasnip_snippets.common.snip_utils').ft_func,
            })
            require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
    },

    -- NVIM cmp / autocomplete
    { 'ii14/emmylua-nvim', ft = "lua" },
    {
        'onsails/lspkind.nvim',
        config = function()
            require('lspkind').init({
                symbol_map = require("seth.util.icons")
            })
        end
    },
    {
        'echasnovski/mini.starter',
        main = "mini.starter",
        config = true
    },
    {
        'echasnovski/mini.bracketed',
        main = "mini.bracketed",
        event = "VeryLazy",
        config = true,
    },

    -- Sticky buffers (for quickfix, neotree, and others)
    {
        'stevearc/stickybuf.nvim',
        config = true,
    },
}
