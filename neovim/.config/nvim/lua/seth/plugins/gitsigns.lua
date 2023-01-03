local M = {
    'lewis6991/gitsigns.nvim',
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
