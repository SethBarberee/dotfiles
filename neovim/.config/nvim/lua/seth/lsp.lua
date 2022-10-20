local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

-- Get capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Set up our lsp clients with the right options..
local lsp_setup = function(client, bufnr)
    local caps = client.server_capabilities
    require("nvim-navic").attach(client, bufnr)
end

local custom_setup = function(client)
    local bufnr = vim.api.nvim_get_current_buf()
    lsp_setup(client, bufnr)
end

-- Made this a function so I can re-use for luadev/sumneko_lua
local function overwrite_config(config)
    -- Add in our updated capabilities and handler/attach setup function
    config = vim.tbl_deep_extend("force", {
        on_attach = custom_setup,
        capabilities = capabilities,
        handlers = handlers,
        --flags = {
        --  debounce_text_changes = nil,
        --},
    }, config)

    return config
end

local lspconfig = require('lspconfig')

-- Add rounded border to all LSP windows
require('lspconfig.ui.windows').default_options.border = 'rounded'

local null_ls = require('null-ls')
local nls_diags = null_ls.builtins.diagnostics
local nls_format = null_ls.builtins.formatting
local nls_codeActions = null_ls.builtins.code_actions

null_ls.setup {
    sources = {
        nls_diags.vint.with({ extra_args = { "--enable-neovim" } }), -- use vint for vim files and enable neovim syntax
        nls_format.trim_whitespace,
        nls_codeActions.gitsigns,
    },
}

-- Stolen from TJ DeVries and his glorious dotfiles
--
-- Allows me to have all my lsp clients to share the same attach and capabilities
--
-- Have to have a value of 'true' to enable the default server config..
-- Example: pylsp = true
--
-- Tables within are the additional config that is passed to lspconfig
local enabled_lsp = {
    pylsp = true,
    rust_tools = {
        tools = {
            hover_actions = {
                auto_focus = true,
            },
        },
        -- Pass our custom attach function here so rust_analyzer gets nvim-navic and other stuff
        server = {
            on_attach = custom_setup,
        },
    },
    vimls = true,
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--offset-encoding=utf-16", -- needed for null-ls
            "--limit-results=0",
        },
    },

    sumneko_lua = {
        settings = {
            Lua = {
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
                hint = {
                    enable = true,
                },

                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file('', true),
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

    config = overwrite_config(config)

    -- Run each setup
    if server ~= "rust_tools" then
        lspconfig[server].setup(config)
    else
        require('rust-tools').setup(config)
    end
end

for server, config in pairs(enabled_lsp) do
    setup_server(server, config)
end

-- Make sure we don't set tagfunc C/C++ stuff when clangd is working since I want ctags over LSP tags
local group_id = vim.api.nvim_create_augroup("Custom LSP", {}) -- defaults to clear = true

local wk = require("which-key")
vim.api.nvim_create_autocmd({ "LspAttach" }, {
    pattern = { "*.c", "*.h", "*.cpp" },
    group = group_id,
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- I want to use Ctags over the LSP stuff for PMD decomp since I
        -- also have assembly files with tags that are referenced.
        -- TODO: create a better detection to do this for PMD?
        vim.bo[bufnr].tagfunc = ""

        -- Register this custom command we get from Clangd LSP
        wk.register({
            la = { '<cmd>ClangdSwitchSourceHeader<CR>', 'lsp-switch-header/src' },
        }, { prefix = "<leader>" })
    end
})
