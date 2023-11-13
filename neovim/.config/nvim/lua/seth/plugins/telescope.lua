local M = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-ui-select.nvim',
        'benfowler/telescope-luasnip.nvim',
    },
    cmd = "Telescope",
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
            desc = 'Telescope find hidden files'
        },
        {
            '<leader>tg',
            '<cmd>Telescope live_grep<cr>',
            desc = 'Telescope grep'
        },
        {
            '<leader>th',
            '<cmd>Telescope help_tags<cr>',
            desc = "help tags"
        },
        {
            '<leader>tl',
            '<cmd>Telescope current_buffer_fuzzy_find<cr>',
            desc = 'Telescope buffer'
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
    }
}

function M.config()
    -- local wk = require("which-key")
    local telescope = require("telescope")

    telescope.setup {
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    -- even more opts
                }

                -- pseudo code / specification for writing custom displays, like the one
                -- for "codeactions"
                -- specific_opts = {
                --   [kind] = {
                --     make_indexed = function(items) -> indexed_items, width,
                --     make_displayer = function(widths) -> displayer
                --     make_display = function(displayer) -> function(e)
                --     make_ordinal = function(e) -> string
                --   },
                --   -- for example to disable the custom builtin "codeactions" display
                --      do the following
                --   codeactions = false,
                -- }
            }
        }
    }

    -- To get ui-select loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    telescope.load_extension("ui-select")
    telescope.load_extension("dap")
    telescope.load_extension("luasnip")
end

return M
