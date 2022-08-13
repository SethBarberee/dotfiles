local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

-- Get capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Set up our lsp clients with the right options..
local lsp_setup = function(client, bufnr)
    local caps = client.server_capabilities

    if caps.completionProvider then
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    end
    -- Use LSP for formatexpr
    if caps.documentFormattingProvider then
        vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    end

    if caps.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
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
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--offset-encoding=utf-16",
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


-- NVIM cmp
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

-- Load the snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()


-- Used by luasnip
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
                tags = "[Tags]",
                ultisnips = "[UltiSnip]",
            }),
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            --before = function (entry, vim_item)
            --    ...
            --    return vim_item
            --end
        })
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
    }),
    -- Buffer only gets showed when no other source is available
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp_signature_help' },
        },
        {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
            { name = 'tags', keyword_length = 3 },
        },
        {
            { name = 'buffer', keyword_length = 5 },
        })
})

-- Disable nvim-cmp on vim-clap
cmp.setup.filetype('clap_input', {
    enabled = false,
})
