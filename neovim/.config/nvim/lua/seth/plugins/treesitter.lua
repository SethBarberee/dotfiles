---@diagnostic disable: missing-fields
return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = "VeryLazy",
        init = function(plugin)
            -- NOTE: taken from LazyVim
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treeitter** module to be loaded in time.
            -- Luckily, the only thins that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            { 'lmburns/nvim-gps', config = true },
            "eckon/treesitter-current-functions",
            {
                'nvim-treesitter/nvim-treesitter-context',
                opts = {
                    max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
                },
            },
            {
                'kiyoon/treesitter-indent-object.nvim',
                keys = {
                    {
                        "ai",
                        "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
                        mode = { "x", "o" },
                        desc = "Select context-aware indent (outer)",
                    },
                    {
                        "aI",
                        "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
                        mode = { "x", "o" },
                        desc = "Select context-aware indent (outer, line-wise)",
                    },
                    {
                        "ii",
                        "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
                        mode = { "x", "o" },
                        desc = "Select context-aware indent (inner, partial range)",
                    },
                    {
                        "iI",
                        "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",
                        mode = { "x", "o" },
                        desc = "Select context-aware indent (inner, entire range)",
                    },
                },
            },
        },
        config = function()
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
                            ['@function.outer'] = 'V',  -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                    },
                },
            }
            local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
            parser_config.asm = {
                install_info = {
                    url = "~/tree-sitter-asm", -- local path or git repo
                    files = { "src/parser.c" },
                    -- optional entries:
                    --branch = "main", -- default branch in case of git repo if different from master
                    generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
                    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
                },
                filetype = "asm",                           -- if filetype does not match the parser name
            }
            parser_config.poryscript = {
                install_info = {
                    url = "https://github.com/V-FEXrt/tree-sitter-poryscript",
                    files = { "src/parser.c" },
                    -- optional entries:
                    branch = "main",                       -- default branch in case of git repo if different from master
                    generate_requires_npm = false,         -- if stand-alone parser without npm dependencies
                    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
                },
                filetype = "pory",                         -- if filetype does not match the parser name
            }
        end,
    },
}
