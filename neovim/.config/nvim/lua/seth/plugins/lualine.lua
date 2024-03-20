local sethconfig = require('seth.config')

local M = {
    'nvim-lualine/lualine.nvim', -- statusline
    init = function()
        vim.keymap.set('n', '1', [[<Cmd>LualineBuffersJump! 1 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '2', [[<Cmd>LualineBuffersJump! 2 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '3', [[<Cmd>LualineBuffersJump! 3 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '4', [[<Cmd>LualineBuffersJump! 4 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '5', [[<Cmd>LualineBuffersJump! 5 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '6', [[<Cmd>LualineBuffersJump! 6 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '7', [[<Cmd>LualineBuffersJump! 7 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '8', [[<Cmd>LualineBuffersJump! 8 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '9', [[<Cmd>LualineBuffersJump! 9 <CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '0', [[<Cmd>LualineBuffersJump! 10 <CR>]], { noremap = true, silent = true })
    end,
    opts = function()
        local navic = {}
        if sethconfig.lsp then
            navic = require("nvim-navic")
        end

        -- Format my lualine tag data
        local function lualine_tags()
            return vim.b.vista_nearest_or_function or ''
        end

        -- Don't show gitInfo and filetype for these filetypes
        local ftBlacklist = {
            ['help'] = true,
            ['vista'] = true,
            ['vista_kind'] = true,
            ['qf'] = true,
            ['checkhealth'] = true,
            ['tsplayground'] = true,
            --['neo-tree'] = true,
        }

        -- Using the blacklist, we take out a few compenents on certain filetypes:
        -- git branch
        -- encoding
        -- fileformat
        -- filetype
        local function lualine_mini()
            return not ftBlacklist[vim.bo.filetype]
        end

        -- Determine when we show the filename
        local function lualine_filename_cond()
            return vim.bo.filetype == 'help' or not ftBlacklist[vim.bo.filetype]
        end

        --- Change the mode based on the filetype
        local custom_mode = {
            help = "HELP",
            vista_kind = "VISTA",
            tsplayground = "TREESITTER",
            qf = 'QUICKFIX',
            Glance = 'Glance',
            --['neo-tree'] = 'NEOTREE',
            --['neo-tree-popup'] = 'NEOTREE',
        }

        --- Format my lualine mode
        -- @param str the original mode from lualine
        local function lualine_mode(str)
            return custom_mode[vim.bo.filetype] or str
        end

        --- Format my lualine filename
        -- @param str the original filename from lualine
        local function lualine_filename(str)
            str = str:gsub("(__vista__)", "Tags")
            str = str:gsub("(NetrwTreeListing)", "Netrw")
            return str
        end

        local function diff_source()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
                return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed
                }
            end
        end

        return {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    -- Neotree and dap-repl have custom winbar so make sure lualine doesn't override it
                    winbar = { 'qf', 'neo-tree', 'dap-repl' },
                },
                always_divide_middle = true,
                globalstatus = true, -- NOTE: this overrides vim.opt.laststatus
            },
            sections = {
                lualine_a = { { 'mode', fmt = lualine_mode } },
                lualine_b = { { 'b:gitsigns_head', cond = lualine_mini, icon = '' },
                    { 'diff', colored = false, source = diff_source },
                    { 'diagnostics', colored = false } },
                lualine_c = { { 'filename', cond = lualine_filename_cond, fmt = lualine_filename } },
                lualine_x = { { 'encoding', cond = lualine_mini }, { 'fileformat', cond = lualine_mini },
                    { 'filetype', cond = lualine_mini } },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', fmt = lualine_filename } },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = { { 'buffers' } },
                lualine_b = { '' },
                lualine_c = { '' },
                lualine_x = {},
                lualine_y = { 'tabs' },
                lualine_z = { "os.date('%H:%M')" }
            },
            -- Use the c component so we have a normal BG and not the light blue background like the mode indicator
            winbar = {
                lualine_c = { { "navic" },
                    {
                        lualine_tags,
                        cond = function()
                            return not navic.is_available()
                        end
                    }
                },
            },
            inactive_winbar = {
                lualine_a = { { 'filename', fmt = lualine_filename } },
                lualine_b = { '' },
                lualine_c = { '' },
                lualine_x = { '' },
                lualine_y = { '' },
                lualine_z = { '' }
            },

            extensions = { 'nvim-dap-ui', 'fugitive', 'neo-tree', 'lazy' }
        }
    end
}

return M
