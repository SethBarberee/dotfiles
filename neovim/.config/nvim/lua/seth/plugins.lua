return {

    -- Looks/UI

    --{ "SethBarberee/challenger_deep.nvim", name = "challenger-deep", priority = 1000 },
    { dir = "~/challenger-deep.nvim", name = "challenger-deep", priority = 1000 },
    'nvim-lua/plenary.nvim',
    'edkolev/tmuxline.vim', -- tmux statusline based on statusline
    'nvim-tree/nvim-web-devicons',
    'folke/lazy.nvim',

    -- Utils
    'airblade/vim-rooter', -- auto cd to base dir of project

    -- Tags
    'ludovicchabant/vim-gutentags', --tag management
    'liuchengxu/vista.vim',

    'dstein64/vim-startuptime',

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

    'sgur/vim-editorconfig', -- to honor editorconfig

    -- Markdown Rendering
    { 'iamcco/markdown-preview.nvim', ft = "markdown" },

    -- NVIM cmp / autocomplete
    'ii14/emmylua-nvim',
    'onsails/lspkind.nvim',
}
