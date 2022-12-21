local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.asm = {
    install_info = {
        url = "~/tree-sitter-asm", -- local path or git repo
        files = { "src/parser.c" },
        -- optional entries:
        --branch = "main", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "asm", -- if filetype does not match the parser name
}

require('nvim-treesitter.configs').setup {
    -- Make sure these are installed
    ensure_installed = "all",
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = "vim",

        -- Seems like treesitter is a lot better now so let's enable it for every c file again
        --disable = function(lang, bufnr) -- Disable in large C buffers
        --    return lang == "c" and vim.api.nvim_buf_line_count(bufnr) > 8000
        --end,
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
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["av"] = "@parameter.outer",
                ["iv"] = "@parameter.inner",
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
        },
        --lsp_interop = {
        --    enable = true,
        --    border = 'rounded',
        --    peek_definition_code = {
        --        ["<leader>df"] = "@function.outer",
        --        ["<leader>dF"] = "@class.outer",
        --    },
        --},
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
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
