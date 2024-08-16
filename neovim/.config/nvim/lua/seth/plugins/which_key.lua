local sethconfig = require('seth.config')

return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    enabled = sethconfig.whichkey,
    opts = {
        win = {
            border = "rounded",
        },
        disable = { filetypes = { "neo-tree" } },
        plugins = {
            spelling = {
                enabled = true,
            },
        },
        icons = {
            mappings = false -- disable icons for which-key
        }
    },
    config = function(_, opts)
        local wk = require("which-key")

        wk.setup(opts)

        wk.add({
            { "<leader>b",  group = "buffers" },
            { "<leader>bl", '<cmd>ls<cr>',                                                  desc = "list-buffers" },
            { "<leader>bd", '<cmd>bd<cr>',                                                  desc = "quit-buffer" },
            { "<leader>d",  group = "dap" },
            { "<leader>db", group = "breakpoints" },
            { "<leader>ds", group = "step" },
            { "<leader>g",  group = "Git" },
            { "<leader>gs", '<cmd>Git<cr>',                                                 desc = "git-status" },
            { "<leader>gb", '<cmd>Git blame<cr>',                                           desc = "git-blame" },
            { "<leader>gd", '<cmd>Gdiffsplit<cr>',                                          desc = "git-diff" },
            { "<leader>hg", '<cmd>Inspect<cr>',                                             desc = "highlight-group" },
            { "<leader>l",  group = "lsp" },
            { "<leader>n",  group = "Neotree" },
            { "<leader>t",  group = "telescope" },
            { "<leader>s",  group = "luasnip" },
            { "<leader>se", '<cmd>lua require("luasnip.loaders").edit_snippet_files()<cr>', desc = "luasnip-edit" },
        })
    end
}
