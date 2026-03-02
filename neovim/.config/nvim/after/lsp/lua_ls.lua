-- Use nvim-lspconfig and add some settings
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            diagnostics = {
                globals = {
                    -- vim
                    "vim",
                },
            },
            completion = {
                callSnippet = "Both"
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                -- NOTE: lazydev is handling this now
                --library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            codeLens = { enable = false }, -- NOTE: disable codelens.. I have different plugin that does this better
            hint = {
                setType = true
            },
        }
    }
})
