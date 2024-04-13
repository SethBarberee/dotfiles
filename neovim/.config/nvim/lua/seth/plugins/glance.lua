local sethconfig = require("seth.config")
return {
    "DNLHC/glance.nvim",
    enabled = sethconfig.lsp,
    config = true,
    lazy = true,
    keys = {
        { '<leader>ld', "<cmd>Glance definition<cr>",       desc = 'lsp-definition' },
        { '<leader>li', "<cmd>Glance implementations<cr>",  desc = 'lsp-implemenation' },
        -- { '<leader><c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', desc = 'lsp-sighelp' },
        -- { '<leader>lt', vim.lsp.buf.type_definition,  desc = 'lsp-typedef' },
        { '<leader>lt', "<cmd>Glance type_definitions<cr>", desc = 'lsp-typedef' },
        -- { '<leader>lr', vim.lsp.buf.references,       desc = 'lsp-references' },
        { '<leader>lr', "<cmd>Glance references<cr>",       desc = 'lsp-references' },
    }
}
