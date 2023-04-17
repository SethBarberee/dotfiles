return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local wk = require("which-key")

        wk.setup {
            window = {
                border = "rounded",
            },
            disable = { filetypes = { "neo-tree" } },
            plugins = {
                spelling = {
                    enabled = true,
                },
            }
        }

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
                -- c         = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'lsp-code_action' },
                -- D         = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'lsp-declaration' },
                -- d         = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'lsp-definition' },
                -- j         = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'lsp-diag-next' },
                -- k         = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'lsp-diag-prev' },
                -- f         = { '<cmd>lua vim.lsp.buf.format()<cr>', 'lsp-formatting' },
                -- h         = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'lsp-hover' },
                -- i         = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'lsp-implemenation' },
                -- ["<c-k>"] = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'lsp-sighelp' },
                -- t         = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'lsp-typedef' },
                -- r         = { '<cmd>lua vim.lsp.buf.references()<cr>', 'lsp-references' },
                -- R         = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'lsp-rename' },
                -- ["0"]     = { '<cmd>lua vim.lsp.buf.document_symbol()<cr>', 'lsp-docsymbol' },
                -- W         = { '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', 'lsp-workspacesymbol' },
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
