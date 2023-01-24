local M = {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
    keys = {
        { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "next-git-hunk" },
        { "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "prev-git-hunk" },
    },
    opts = {
        attach_to_untracked = false,
        preview_config = {
            border = 'rounded',
        },
        signs = {
            add          = { text = '│' },
            change       = { text = '│' },
            delete       = { text = '│' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
    }
}

return M
