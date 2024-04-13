local sethconfig = require("seth.config")
return {
    'SmiteshP/nvim-navic',
    enabled = sethconfig.lsp,
    opts = {
        icons = require('seth.util.icons'),
        highlight = true
    },
    dependencies = 'neovim/nvim-lspconfig'
}
