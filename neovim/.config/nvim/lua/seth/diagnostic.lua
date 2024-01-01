-- Add diag signs in the gutter
for type, icon in pairs(require('seth.util.icons').signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Register Border handler for hover/signature help/diagnostics

-- Add in the border for diagnostics config
local diag_config = {
    float = {
        border = 'rounded',
    },
    virtual_text = false,
    severity_sort = true,

    -- TODO for nvim 0.10 (need to add texthl and numhl)
    -- signs = {
    --     text = {
    --         [vim.diagnostic.severity.ERROR] = require('seth.util.icons').signs.Error,
    --         [vim.diagnostic.severity.WARN] = require('seth.util.icons').signs.Warn,
    --         [vim.diagnostic.severity.HINT] = require('seth.util.icons').signs.Hint,
    --         [vim.diagnostic.severity.INFO] = require('seth.util.icons').signs.Info,
    --     },
    -- },
    -- numhl = {
    --     [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    --     [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    --     [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    --     [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    -- },
    -- texthl = {
    --     [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    --     [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    --     [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    --     [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    -- }
}

vim.diagnostic.config(diag_config)
