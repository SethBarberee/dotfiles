local M = {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
}

function M.config()
    require('gitsigns').setup {
        attach_to_untracked = false,
        preview_config = {
            border = 'rounded',
        }
    }
end

return M
