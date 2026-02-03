---@diagnostic disable: missing-fields
local sethconfig = require("seth.config")

return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = "VeryLazy",
        enabled = sethconfig.treesitter,
        init = function(plugin)
            -- NOTE: taken from LazyVim
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treeitter** module to be loaded in time.
            -- Luckily, the only thins that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            --require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
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
            require('nvim-treesitter').install({ 'c', 'lua', 'rust', 'query', 'bash', 'make' }):wait(300000) -- wait max. 5 minutes
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'c', 'lua', 'rust', 'query', 'bash', 'make', 'arm' },
                callback = function() vim.treesitter.start() end,
            })

            vim.api.nvim_create_autocmd('User', {
                pattern = { 'TSUpdate' },
                callback = function()
                    require('nvim-treesitter.parsers').arm = {
                        install_info = {
                            path = "~/tree-sitter-asm", -- local path or git repo
                            -- optional entries:
                            --branch = "main", -- default branch in case of git repo if different from master
                            generate = true, -- if folder contains pre-generated src/parser.c
                        },
                    }
                    require('nvim-treesitter.parsers').poryscript = {
                        install_info = {
                            url = "https://github.com/Elsie19/treesitter-poryscript",
                            -- optional entries:
                            --branch = "main", -- default branch in case of git repo if different from master
                            generate = true, -- if folder contains pre-generated src/parser.c
                        },
                    }
                end
            })

            vim.treesitter.language.register('arm', { 'arm' })
            vim.treesitter.language.register('poryscript', { 'pory' })
        end
    }
}
