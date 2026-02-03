---@diagnostic disable: missing-fields
local sethconfig = require("seth.config")

return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        lazy = false,
        enabled = sethconfig.treesitter,
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

            vim.api.nvim_create_autocmd('User', {
                pattern = { 'TSUpdate' },
                callback = function()
                    require('nvim-treesitter.parsers').arm = {
                        install_info = {
                            path = "~/tree-sitter-asm", -- local path or git repo
                            generate = true,            -- if folder contains pre-generated src/parser.c
                            queries = 'queries',
                        },
                    }
                    require('nvim-treesitter.parsers').poryscript = {
                        install_info = {
                            path = "~/treesitter-poryscript",
                            generate = true, -- if folder contains pre-generated src/parser.c
                            queries = 'queries/poryscript',
                        },
                    }
                end
            })

            vim.treesitter.language.register('arm', { 'arm' })
            vim.treesitter.language.register('poryscript', { 'pory', 'poryscript' })
        end
    }
}
