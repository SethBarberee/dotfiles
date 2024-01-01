-- Use legacy tag for fidget until rewrite is done
return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    opts = { sources = { ["null-ls"] = { ignore = true } } }
} -- Lsp status notifications
