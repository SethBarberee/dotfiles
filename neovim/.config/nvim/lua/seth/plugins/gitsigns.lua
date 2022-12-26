local M = {
    'lewis6991/gitsigns.nvim',
}

function M.config()
    require('gitsigns').setup {
        attach_to_untracked = false,
    }
end

return M
