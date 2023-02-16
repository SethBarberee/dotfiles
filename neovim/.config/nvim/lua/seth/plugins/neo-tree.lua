return {
    'nvim-neo-tree/neo-tree.nvim',
    --cmd = "Neotree",
    dependencies = {
        'MunifTanjim/nui.nvim', -- for neotree
    },
    cmd = "Neotree",
    keys = {
        { "<leader>nf", "<cmd>Neotree toggle<cr>",     desc = "files" },
        { "<leader>nb", "<cmd>Neotree buffers<cr>",    desc = "buffers" },
        { "<leader>ng", "<cmd>Neotree git_status<cr>", desc = "git" },
    },
    opts = {
        filesystem = {
            follow_current_file = true,
            filtered_items = {
                hide_dotfiles = false,
            },
        },
        source_selector = {
            winbar = true,
        }
    }
}
