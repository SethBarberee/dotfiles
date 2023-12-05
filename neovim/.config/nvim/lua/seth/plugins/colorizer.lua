return {
    'NvChad/nvim-colorizer.lua',
    opts = {
        filetypes = {
            "*",         -- highlight all filetypes
            "!neo-tree", -- neo-tree has # numbers and we don't want that to highlight
        }
    }
}
