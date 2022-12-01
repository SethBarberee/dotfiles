local handlers = require "seth.lsp.handlers"

-- Get capabilities from nvim-cmp
local updated_capabilities = require('cmp_nvim_lsp').default_capabilities()

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

local wk = require("which-key")
local filetype_attach = setmetatable({

  python = function()
    autocmd_format(false)
  end,

  c = function()
        -- I want to use Ctags over the LSP stuff for PMD decomp since I
        -- also have assembly files with tags that are referenced.
        -- TODO: create a better detection to do this for PMD?
        vim.bo.tagfunc = ""

        -- Register this custom command we get from Clangd LSP
        wk.register({
            la = { '<cmd>ClangdSwitchSourceHeader<CR>', 'lsp-switch-header/src' },
        }, { prefix = "<leader>" })

  end,

}, {
  __index = function()
    return function() end
  end,
})

-- Set up our lsp clients with the right options..
local custom_attach = function(client)
    local bufnr = vim.api.nvim_get_current_buf()

    require("nvim-navic").attach(client, bufnr)

    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

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
    pylsp = true,
    rust_tools = {
        tools = {
            hover_actions = {
                auto_focus = true,
            },
        },
        -- Pass our custom attach function here so rust_analyzer gets nvim-navic and other stuff
        server = {
            on_attach = custom_attach,
            capabilities = updated_capabilities,
        },
    },
    vimls = true,
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--offset-encoding=utf-16", -- defaults to utf-16
            "--limit-results=0",
        },
        init_options = {
          clangdFileStatus = true,
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
    if server ~= "rust_tools" then
        lspconfig[server].setup(config)
    else
        require('rust-tools').setup(config)
    end
end

for server, config in pairs(enabled_lsp) do
    setup_server(server, config)
end


-- NULL LS

local null_ls = require('null-ls')
local nls_diags = null_ls.builtins.diagnostics
local nls_format = null_ls.builtins.formatting
local nls_codeActions = null_ls.builtins.code_actions

null_ls.setup {
    sources = {
        nls_diags.vint.with({ extra_args = { "--enable-neovim" } }), -- use vint for vim files and enable neovim syntax
        nls_format.trim_whitespace,
        nls_codeActions.gitsigns,
        nls_format.black,
    },
}
