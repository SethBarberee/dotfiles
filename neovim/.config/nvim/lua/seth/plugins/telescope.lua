local M = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-ui-select.nvim',
        'benfowler/telescope-luasnip.nvim',
    },
    event = "VeryLazy"
}

function M.config()
    local wk = require("which-key")
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

    wk.register({
        t = {
            name = "telescope",
            m = { '<cmd>Telescope<cr>', 'main-menu' },
            d = { '<cmd>Telescope diagnostics<cr>', 'diagnostics' },
            s = { '<cmd>lua require("telescope.builtin").find_files({hidden=true})<cr>', 'telescope-file' },
            g = { '<cmd>Telescope live_grep<cr>', 'grep' },
            h = { '<cmd>Telescope help_tags<cr>', 'help-tags' },
            l = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'telescope-line' },
            n = { '<cmd>Telescope luasnip<cr>', 'telescope-luasnip' },
            t = { '<cmd>Telescope tags<cr>', 'project-tags' },
        },
    }, { prefix = '<leader>' })
end

return M
