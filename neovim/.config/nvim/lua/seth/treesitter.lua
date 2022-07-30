require('nvim-treesitter.configs').setup {
    -- Make sure these are installed
    ensure_installed = "all",
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = "vim",
        disable = function(lang, bufnr) -- Disable in large C buffers (found that 2000 lines is a good limit)
            return lang == "c" and vim.api.nvim_buf_line_count(bufnr) > 6000
        end,
    },
    indent = {
        enable = true,
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    refactor = {
        highlight_current_scope = { enable = true },
        highlight_definitions = {
            enable = true,
        }
    }
}

require('treesitter-context').setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            'for', -- These won't appear in the context
            -- 'while',
            'if',
            'switch',
            'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
    --exact_patterns = {
    -- Example for a specific filetype with Lua patterns
    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
    -- exactly match "impl_item" only)
    -- rust = true,
    --},

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    --zindex = 20, -- The Z-index of the context window
}
