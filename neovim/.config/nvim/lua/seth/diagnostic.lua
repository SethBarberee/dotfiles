-- Add diag signs in the gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Register Border handler for hover/signature help/diagnostics

-- Add in the border for diagnostics config
local diag_config = {
    float = {
        border = 'rounded',
    }
}

vim.diagnostic.config(diag_config)
