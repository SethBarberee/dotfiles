
local common_lsp = {}

-- Get capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

function common_lsp.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local caps = client.server_capabilities
    if not caps.documentSymbolProvider then
        return
    end
    require("nvim-navic").attach(client, bufnr)
end

require('lspconfig').clangd.setup{
    -- Stolen from TJ DeVries and his glorious dotfiles
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
    on_attach = common_lsp.on_attach,
    capabilities = capabilities
}

require('lspconfig').pylsp.setup{
    on_attach = common_lsp.on_attach,
    capabilities = capabilities
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')


require('lspconfig').sumneko_lua.setup{
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = common_lsp.on_attach,
    capabilities = capabilities
}

require('lspconfig').vimls.setup{
    on_attach = common_lsp.on_attach,
    capabilities = capabilities
}

local cmp = require'cmp'
local lspkind = require'lspkind'
local cmp_ultisnips_mappings = require'cmp_nvim_ultisnips.mappings'

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
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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
       { name = 'nvim_lsp_signature_help'},
    },
    {
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
      { name = 'nvim_lua' },
      { name = 'tags'},
    },
    {
      { name = 'buffer' },
    })
  })
