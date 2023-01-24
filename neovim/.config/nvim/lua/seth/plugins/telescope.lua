local M = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-ui-select.nvim',
        'benfowler/telescope-luasnip.nvim',
    },
    event = "VeryLazy"
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

    vim.keymap.set('n', '<leader>tm', '<cmd>Telescope<cr>', { silent = true, noremap = true, nowait = false })
    vim.keymap.set('n', '<leader>td', '<cmd>Telescope diagnostics<cr>',
        { silent = true, noremap = true, nowait = false })
    vim.keymap.set('n', '<leader>ts', '<cmd>lua require("telescope.builtin").find_files({hidden=true})<cr>',
        { silent = true, noremap = true, nowait = false, desc = 'Telescope find hidden files' })
    vim.keymap.set('n', '<leader>tg', '<cmd>Telescope live_grep<cr>',
        { silent = true, noremap = true, nowait = false, desc = 'Telescope grep' })
    vim.keymap.set('n', '<leader>th', '<cmd>Telescope help_tags<cr>',
        { silent = true, noremap = true, nowait = false })
    vim.keymap.set('n', '<leader>tl', '<cmd>Telescope current_buffer_fuzzy_find<cr>',
        { silent = true, noremap = true, nowait = false, desc = 'Telescope buffer' })
    vim.keymap.set('n', '<leader>tn', '<cmd>Telescope luasnip<cr>',
        { silent = true, noremap = true, nowait = false })
    vim.keymap.set('n', '<leader>tt', '<cmd>Telescope tags<cr>',
        { silent = true, noremap = true, nowait = false })
end

return M
