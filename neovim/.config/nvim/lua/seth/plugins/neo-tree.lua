return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v3.x",
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
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        filesystem = {
            follow_current_file = {
                enabled = true
            },
            filtered_items = {
                hide_dotfiles = false,
            },
        },
        source_selector = {
            winbar = true,
        }
    }
}
