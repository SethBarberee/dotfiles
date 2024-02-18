local sethconfig = require('seth.config')

return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    enabled = sethconfig.whichkey,
    opts = {
        window = {
            border = "rounded",
        },
        disable = { filetypes = { "neo-tree" } },
        plugins = {
            spelling = {
                enabled = true,
            },
        }
    },
    config = function(_, opts)
        local wk = require("which-key")

        wk.setup(opts)

        wk.register({
            b = {
                name = "buffers",
                l = { '<cmd>ls<cr>', "list-buffers" },
                q = { '<cmd>bd<cr>', "quit-buffer" },
            },
            d = {
                name = "dap",
                b = {
                    name = "breakpoints",
                },
                s = {
                    name = "step",
                },
            },
            g = {
                name = "Git",
                d = { '<cmd>Gdiffsplit<cr>', 'git-diff' },
                s = { '<cmd>Git<cr>', 'git-status' },
                b = { '<cmd>Git blame<cr>', 'git-blame' },
            },
            h = {
                g = { '<cmd>Inspect<cr>', 'highlight-group' },
            },
            l = {
                name = "lsp",
            },
            n = {
                name = "Neotree",
            },
            s = {
                name = "luasnip",
                e    = { '<cmd>lua require("luasnip.loaders").edit_snippet_files()<cr>', 'luasnip-edit' },
            },
            t = {
                name = "telescope",
            },
        }, { prefix = "<leader>" })
    end
}
