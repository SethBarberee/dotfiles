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

local lspconfig = require('lspconfig')

local luadev = require("lua-dev").setup({})
lspconfig.sumneko_lua.setup(luadev)

local null_ls = require('null-ls')
local nls_diags = null_ls.builtins.diagnostics
local nls_format = null_ls.builtins.formatting

null_ls.setup {
    sources = {
        nls_diags.vint.with({ extra_args = { "--enable-neovim" } }), -- use vint for vim files and enable neovim syntax
        nls_format.trim_whitespace,
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
    rust_analyzer = true,
    vimls = true,
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
        },
    },
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
        on_attach = custom_setup,
        capabilities = capabilities,
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


-- NVIM cmp
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local cmp_ultisnips_mappings = require 'cmp_nvim_ultisnips.mappings'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
            end,
            { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                cmp_ultisnips_mappings.jump_backwards(fallback)
            end,
            { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
    }),

    -- Buffer only gets showed when no other source is available
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp_signature_help' },
        },
        {
            { name = 'nvim_lsp' },
            { name = 'ultisnips' }, -- For ultisnips users.
            { name = 'nvim_lua' },
            { name = 'tags' },
        },
        {
            { name = 'buffer' },
        })
})

-- Disable nvim-cmp on vim-clap
cmp.setup.filetype('clap_input', {
    enabled = false,
})
