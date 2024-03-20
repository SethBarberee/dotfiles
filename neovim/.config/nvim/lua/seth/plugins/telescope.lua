local sethconfig = require('seth.config')

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-ui-select.nvim',
        'benfowler/telescope-luasnip.nvim',
        'nvim-lua/plenary.nvim'
    },
    event = "VeryLazy", -- NOTE: still need to load for ui-select.. can't lazyload on cmd/keys
    keys = {
        { '<leader>tm', '<cmd>Telescope<cr>', desc = "main" },
        {
            '<leader>td',
            '<cmd>Telescope diagnostics<cr>',
            desc = "diagnostics"
        },
        {
            '<leader>ts',
            '<cmd>lua require("telescope.builtin").find_files({hidden=true})<cr>',
            desc = 'find hidden files'
        },
        {
            '<leader>tf',
            '<cmd>Telescope treesitter<cr>',
            desc = "treesitter"
        },
        {
            '<leader>tg',
            '<cmd>Telescope live_grep<cr>',
            desc = 'grep'
        },
        {
            '<leader>th',
            '<cmd>Telescope help_tags<cr>',
            desc = "help tags"
        },
        {
            '<leader>ti',
            '<cmd>Telescope git_files<cr>',
            desc = 'git files'
        },
        {
            '<leader>tl',
            '<cmd>Telescope current_buffer_fuzzy_find<cr>',
            desc = 'buffer'
        },
        {
            '<leader>tn',
            '<cmd>Telescope luasnip<cr>',
            desc = "luasnip"
        },
        {
            '<leader>tt',
            '<cmd>Telescope tags<cr>',
            desc = "tags"
        },
    },
    config = function()
        require("telescope").setup {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- even more opts
                    }
                },
            }
        }

        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")
        if sethconfig.dap then require("telescope").load_extension("dap") end
        require("telescope").load_extension("luasnip")
    end
}
