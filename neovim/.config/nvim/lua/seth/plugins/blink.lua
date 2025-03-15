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

        snippets = { preset = 'luasnip' },

        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.

        cmdline = {
            keymap = {
                preset = "default"
            }
        },

        keymap = {
            preset = 'super-tab',
            -- Adding both Ctrl-Y and Enter keys because I can't decide on selection and
            -- I like super tab for snippets/cmdline
            ['<C-y>'] = { 'select_and_accept' },
            ['<CR>'] = { 'accept', 'fallback' },
        },

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

        sources = {
            min_keyword_length = function(ctx)
                -- only applies when typing a command, doesn't apply to arguments
                if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
                return 0
            end,
            providers = {
                lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', fallbacks = { "lsp" }, score_offset = 3000 },
            },
            default = { 'lazydev', 'snippets', 'lsp', 'path', 'buffer' },
        },

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
                    -- treesitter = { 'lsp' },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                return require('lspkind').symbolic(ctx.kind, {
                                    mode = 'symbol_text',
                                })
                            end,
                            highlight = function(ctx)
                                return 'BlinkCmpKind' .. ctx.kind
                            end,
                        },
                    }
                }
            }
        }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }
}
