local M = {
    'neovim/nvim-lspconfig',
    dependencies = {
        { "j-hui/fidget.nvim",     opts = { sources = { ["null-ls"] = { ignore = true } } } }, -- Lsp status notifications
        {
            'SmiteshP/nvim-navic',
            opts = {
                icons = require('seth.util.icons'),
                highlight = true
            }
        },
        { 'SmiteshP/nvim-navbuddy' },
        { "folke/neodev.nvim",     config = true },
    },
    event = "BufReadPre",
    keys = {
        { '<leader>lc', vim.lsp.buf.code_action,      desc = 'lsp-code_action' },
        { '<leader>lD', vim.lsp.buf.declaration,      desc = 'lsp-declaration' },
        { '<leader>ld', vim.lsp.buf.definition,       desc = 'lsp-definition' },
        { '<leader>lj', vim.diagnostic.goto_next,     desc = 'lsp-diag-next' },
        { '<leader>lk', vim.diagnostic.goto_prev,     desc = 'lsp-diag-prev' },
        { '<leader>lf', vim.lsp.buf.format,           desc = 'lsp-formatting' },
        { '<leader>lh', vim.lsp.buf.hover,            desc = 'lsp-hover' },
        { '<leader>li', vim.lsp.buf.implementation,   desc = 'lsp-implemenation' },
        { '<leader>ln', "<cmd>Navbuddy<cr>",          desc = 'lsp-nav' },
        --{ '<leader><c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', desc = 'lsp-sighelp' },
        { '<leader>lt', vim.lsp.buf.type_definition,  desc = 'lsp-typedef' },
        { '<leader>lr', vim.lsp.buf.references,       desc = 'lsp-references' },
        { '<leader>lR', vim.lsp.buf.rename,           desc = 'lsp-rename' },
        { '<leader>l0', vim.lsp.buf.document_symbol,  desc = 'lsp-docsymbol' },
        { '<leader>lW', vim.lsp.buf.workspace_symbol, desc = 'lsp-workspacesymbol' },
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
            --autocmd_format(false)
        end,
        lua = function()
            autocmd_format(false)
        end,
        c = function()
            -- I want to use Ctags over the LSP stuff for PMD decomp since I
            -- also have assembly files with tags that are referenced.
            -- TODO: create a better detection to do this for PMD?
            vim.bo.tagfunc = ""

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

        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
            require("nvim-navbuddy").attach(client, bufnr)
        end

        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

        filetype_attach[filetype](client)
    end

    local lspconfig = require('lspconfig')


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
        --pylsp = true,
        --pyright = true,
        jedi_language_server = true,
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
                --"--offset-encoding=utf-32", -- defaults to utf-16
                "--limit-results=0",
                "--enable-config",
            },
            init_options = {
                clangdFileStatus = true,
            },
        },
        --ccls = true,

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
            --flags = {
            --  debounce_text_changes = nil,
            --},
        }, config)

        -- Run each setup
        lspconfig[server].setup(config)
    end

    for server, config in pairs(enabled_lsp) do
        setup_server(server, config)
    end

    require("seth.plugins.null-ls").setup()
end

return M
