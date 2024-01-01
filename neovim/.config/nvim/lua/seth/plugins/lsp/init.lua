-- Taken from @pseudometapseudo on Reddit
vim.api.nvim_create_user_command("LspCapabilities", function()
    local curBuf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_active_clients { bufnr = curBuf }

    for _, client in pairs(clients) do
        local capAsList = {}
        for key, value in pairs(client.server_capabilities) do
            if value and key:find("Provider") then
                local capability = key:gsub("Provider$", "")
                table.insert(capAsList, "- " .. capability)
            end
        end
        table.sort(capAsList) -- sorts alphabetically
        local msg = "# " .. client.name .. "\n" .. table.concat(capAsList, "\n")
        vim.notify(msg, vim.log.levels.TRACE, {
            on_open = function(win)
                local buf = vim.api.nvim_win_get_buf(win)
                vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
            end,
            timeout = 14000,
        })
        vim.fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
    end
end, {})

local M = {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'SmiteshP/nvim-navic',
            opts = {
                icons = require('seth.util.icons'),
                highlight = true
            }
        },
        { "folke/neodev.nvim", config = true },
        {
            'SmiteshP/nvim-navbuddy',
            lazy = true,
        },
        { "DNLHC/glance.nvim", config = true, lazy = true },
    },
    event = "BufReadPre",
    keys = {
        { '<leader>lc', vim.lsp.buf.code_action,            desc = 'lsp-code_action' },
        { '<leader>lD', vim.lsp.buf.declaration,            desc = 'lsp-declaration' },
        -- { '<leader>ld', vim.lsp.buf.definition,       desc = 'lsp-definition' },
        { '<leader>ld', "<cmd>Glance definition<cr>",       desc = 'lsp-definition' },
        { '<leader>lj', vim.diagnostic.goto_next,           desc = 'lsp-diag-next' },
        { '<leader>lk', vim.diagnostic.goto_prev,           desc = 'lsp-diag-prev' },
        { '<leader>lF', "<cmd>LspInfo<cr>",                 desc = 'lsp-info' },
        { '<leader>lf', vim.lsp.buf.format,                 desc = 'lsp-formatting' },
        { '<leader>lh', vim.lsp.buf.hover,                  desc = 'lsp-hover' },
        { '<leader>lI', "<cmd>LspCapabilities<cr>",         desc = 'lsp-capabilities' },
        -- { '<leader>li', vim.lsp.buf.implementation,        desc = 'lsp-implemenation' },
        { '<leader>li', "<cmd>Glance implementations<cr>",  desc = 'lsp-implemenation' },
        { '<leader>ln', "<cmd>Navbuddy<cr>",                desc = 'lsp-nav' },
        -- { '<leader><c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', desc = 'lsp-sighelp' },
        -- { '<leader>lt', vim.lsp.buf.type_definition,  desc = 'lsp-typedef' },
        { '<leader>lt', "<cmd>Glance type_definitions<cr>", desc = 'lsp-typedef' },
        -- { '<leader>lr', vim.lsp.buf.references,       desc = 'lsp-references' },
        { '<leader>lr', "<cmd>Glance references<cr>",       desc = 'lsp-references' },
        { '<leader>lR', vim.lsp.buf.rename,                 desc = 'lsp-rename' },
        { '<leader>l0', vim.lsp.buf.document_symbol,        desc = 'lsp-docsymbol' },
        { '<leader>lW', vim.lsp.buf.workspace_symbol,       desc = 'lsp-workspacesymbol' },
        { '<leader>ll', vim.lsp.codelens.run,               desc = 'lsp-codelens-run' },
    },
}


function M.config()
    local handlers = require "seth.plugins.lsp.handlers"

    -- Get capabilities from nvim-cmp
    local updated_capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Tell the server the capability of foldingRange,
    -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
    updated_capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    local augroup_format = vim.api.nvim_create_augroup("Custom LSP Format", {}) -- defaults to clear = true

    local autocmd_format = function(async, filter)
        vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = 0,
            callback = function()
                vim.lsp.buf.format { async = async, filter = filter }
            end,
        })
    end

    local filetype_attach = setmetatable({
        python = function()
            autocmd_format(false)
        end,
        lua = function()
            autocmd_format(false)
        end,
        c = function()
            -- I want to use Ctags over the LSP stuff for PMD decomp since I
            -- also have assembly files with tags that are referenced.
            local current_dir = vim.fn.getcwd(-1, -1)
            local basename = vim.fs.basename(current_dir)
            --print(basename)
            if basename == "pmd-red" then
                vim.bo.tagfunc = ""
            end

            -- Register this custom command we get from Clangd LSP
            vim.keymap.set('n', '<leader>la', '<cmd>ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })
        end,
    }, {
        __index = function()
            return function()
            end
        end,
    })

    -- Set up our lsp clients with the right options..
    local custom_attach = function(client)
        local bufnr = vim.api.nvim_get_current_buf()

        -- Only enable inlay hints on 0.10
        if client.server_capabilities.inlayHintProvider and vim.fn.has('nvim-0.10') == 1 then
            vim.g.inlay_hints_visible = true
            vim.lsp.inlay_hint(bufnr, true)
        end

        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
            require("nvim-navbuddy").attach(client, bufnr)
        end

        -- Setup codelens for supported LSPs
        if client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = 0,
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
            })
        end

        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

        filetype_attach[filetype](client)
    end

    -- Add rounded border to all LSP windows
    require('lspconfig.ui.windows').default_options.border = 'rounded'


    -- Stolen from TJ DeVries and his glorious dotfiles
    --
    -- Allows me to have all my lsp clients to share the same attach and capabilities
    --
    -- Have to have a value of 'true' to enable the default server config..
    -- Example: pylsp = true
    --
    -- Tables within are the additional config that is passed to lspconfig
    local enabled_lsp = {
        pylsp = {
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = { 'E261' },
                            maxLineLength = 100,
                        }
                    }
                }
            },
        },
        --pyright = true,
        --jedi_language_server = true,
        rust_analyzer = true,
        vimls = true,
        poryscript_lsp = true,
        jsonls = true,
        clangd = {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "-j=8",
                "--malloc-trim",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--limit-results=0",
                "--enable-config",
            },
            init_options = {
                clangdFileStatus = true,
            },
        },

        lua_ls = {
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
                        -- NOTE: neodev is handling this now
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
    }

    local setup_server = function(server, config)
        if not config then
            return
        end

        if type(config) ~= "table" then
            config = {}
        end

        -- Add in our updated capabilities and handler/attach setup function
        config = vim.tbl_deep_extend("force", {
            on_attach = custom_attach,
            capabilities = updated_capabilities,
            handlers = handlers,
        }, config)

        -- Run each setup
        require('lspconfig')[server].setup(config)
    end

    for server, config in pairs(enabled_lsp) do
        setup_server(server, config)
    end
end

return M
