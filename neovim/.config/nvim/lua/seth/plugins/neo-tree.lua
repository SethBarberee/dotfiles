return {
    'nvim-neo-tree/neo-tree.nvim',
    --cmd = "Neotree",
    dependencies = {
        'MunifTanjim/nui.nvim', -- for neotree
    },
    cmd = "Neotree",
    config = {
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
