return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    -- vim
                    "vim",

                    -- Busted
                    "describe",
                    "it",
                    "before_each",
                    "after_each",
                    "teardown",
                    "pending",
                    "clear",

                    -- Custom
                    "RELOAD",
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
            hint = {
                enable = vim.fn.has('nvim-0.10') == 1,
                setType = true
            },
        }
    }
}
