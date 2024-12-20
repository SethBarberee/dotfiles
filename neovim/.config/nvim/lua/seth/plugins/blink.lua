---@diagnostic disable: missing-fields
return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- dependencies = 'rafamadriz/friendly-snippets',
    dependencies = {
        { 'L3MON4D3/LuaSnip', version = 'v2.*' },
        'onsails/lspkind.nvim',
    },

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        snippets = {
            expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
            active = function(filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,
            jump = function(direction) require('luasnip').jump(direction) end,
        },

        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        keymap = { preset = 'default', },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`

        sources = { completion = { enabled_providers = { 'luasnip', 'lsp', 'path', 'buffer' } } },
        -- sources = {
        --     -- default = { 'lsp', 'path', 'luasnip', 'buffer', 'lazydev' },
        --     default = { 'luasnip', 'lsp', 'path', 'buffer' },
        --
        --     -- optionally disable cmdline completions
        --     -- cmdline = {},
        --     providers = {
        --         -- dont show LuaLS require statements when lazydev has items
        --         -- lsp = { fallback_for = { 'lazydev' } },
        --         -- lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
        --     },
        -- },

        -- experimental signature help support
        signature = {
            enabled = true,
            window = { border = 'rounded' }
        },

        completion = {
            accept = { auto_brackets = { enabled = true, } },
            documentation = {
                auto_show = true,
                window = { border = 'rounded' }
            },
            menu = {
                draw = {
                    columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                return require('lspkind').symbolic(ctx.kind, {
                                    mode = 'symbol_text',
                                })
                            end,
                            highlight = function(ctx)
                                return require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx) or
                                    'BlinkCmpKind' .. ctx.kind
                            end,
                        },
                    }
                }
            }
        }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.completion.enabled_providers" }
}
