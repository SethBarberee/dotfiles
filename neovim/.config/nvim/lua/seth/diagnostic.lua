-- Add diag signs in the gutter

local diag_icons = require('seth.util.icons').signs

-- Add in the border for diagnostics config
local diag_config = {
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diag_icons[vim.diagnostic.severity.ERROR],
            [vim.diagnostic.severity.WARN] = diag_icons[vim.diagnostic.severity.WARN],
            [vim.diagnostic.severity.INFO] = diag_icons[vim.diagnostic.severity.INFO],
            [vim.diagnostic.severity.HINT] = diag_icons[vim.diagnostic.severity.HINT],
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
        },
        -- linehl = {
        --     [vim.diagnostic.severity.ERROR] = '',
        --     [vim.diagnostic.severity.WARN] = '',
        --     [vim.diagnostic.severity.INFO] = '',
        --     [vim.diagnostic.severity.HINT] = '',
        -- },
    }
}

vim.diagnostic.config(diag_config)
