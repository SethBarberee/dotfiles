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
}

vim.diagnostic.config(diag_config)
