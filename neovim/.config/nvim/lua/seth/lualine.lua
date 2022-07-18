local lualine = require("lualine")
local navic = require("nvim-navic")
local gps = require("nvim-gps")

local function tags()
    if navic.is_available() and vim.bo.filetype ~= 'python' then
        return navic.get_location()
    elseif gps.is_available() then
        return gps.get_location()
    end
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', { 'diff', colored = false }, { 'diagnostics', colored = false } },
        lualine_c = { 'filename' },
        lualine_x = { tags, 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = { 'buffers' },
        lualine_b = { '' },
        lualine_c = { '' },
        lualine_x = {},
        lualine_y = { 'tabs' },
        lualine_z = { "os.date('%H:%M')" }
    },
    extensions = {}
}

vim.api.nvim_set_keymap('n', '1', [[<Cmd>LualineBuffersJump 1 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '2', [[<Cmd>LualineBuffersJump 2 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '3', [[<Cmd>LualineBuffersJump 3 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '4', [[<Cmd>LualineBuffersJump 4 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '5', [[<Cmd>LualineBuffersJump 5 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '6', [[<Cmd>LualineBuffersJump 6 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '7', [[<Cmd>LualineBuffersJump 7 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '8', [[<Cmd>LualineBuffersJump 8 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '9', [[<Cmd>LualineBuffersJump 9 <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '0', [[<Cmd>LualineBuffersJump 10 <CR>]], { noremap = true, silent = true })
