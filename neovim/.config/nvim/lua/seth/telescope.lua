local wk = require("which-key")

require("telescope").setup {
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
require("telescope").load_extension("ui-select")
require("telescope").load_extension("dap")

wk.register({
    t = {
        name = "telescope",
        m = { '<cmd>Telescope<cr>', 'main-menu' },
        s = { '<cmd>lua require("telescope.builtin").find_files({hidden=true})<cr>', 'telescope-file' },
        g = { '<cmd>Telescope live_grep<cr>', 'grep' },
        h = { '<cmd>Telescope help_tags<cr>', 'help-tags' },
        l = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'telescope-line' },
        t = { '<cmd>Telescope tags<cr>', 'project-tags' },
    },
}, { prefix = '<leader>' })

