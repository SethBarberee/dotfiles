local sethconfig = require("seth.config")
return {
    'SmiteshP/nvim-navbuddy',
    enabled = sethconfig.lsp,
    dependencies = 'neovim/nvim-lspconfig',
    keys = {
        { '<leader>ln', "<cmd>Navbuddy<cr>", desc = 'lsp-nav' }
    }
}
