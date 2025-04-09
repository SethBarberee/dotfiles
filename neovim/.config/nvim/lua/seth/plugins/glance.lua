local sethconfig = require("seth.config")
return {
    "DNLHC/glance.nvim",
    enabled = sethconfig.lsp,
    config = true,
    lazy = true,
    keys = {
        { '<leader>ld', "<cmd>Glance definition<cr>",       desc = 'lsp-definition' },
        { '<leader>li', "<cmd>Glance implementations<cr>",  desc = 'lsp-implemenation' },
        { '<leader>lt', "<cmd>Glance type_definitions<cr>", desc = 'lsp-typedef' },
        { '<leader>lr', "<cmd>Glance references<cr>",       desc = 'lsp-references' },
    }
}
