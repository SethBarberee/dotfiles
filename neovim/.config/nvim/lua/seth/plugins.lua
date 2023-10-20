return {

    -- Looks/UI

    { "SethBarberee/challenger-deep.nvim", name = "challenger-deep", priority = 1000, dev = true },
    { 'wadackel/vim-dogrun',          event = "VeryLazy" },
    { 'felipeagc/fleet-theme-nvim',   event = "VeryLazy" },

    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    'folke/lazy.nvim',

    -- Utils
    { 'notjedi/nvim-rooter.lua',     config = true }, -- auto cd to base dir of project
    'fladson/vim-kitty',

    -- Tags
    'ludovicchabant/vim-gutentags', --tag management
    'liuchengxu/vista.vim',

    { 'dstein64/vim-startuptime', cmd = "StartupTime" },

    -- Git
    'tpope/vim-fugitive',

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        config = function()
            require("luasnip").setup({})
            require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
        end,
    },

    -- NVIM cmp / autocomplete
    'ii14/emmylua-nvim',
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
        main = "mini.starter"
    },
    {
        'echasnovski/mini.bracketed',
        main = "mini.bracketed"
    },
}
