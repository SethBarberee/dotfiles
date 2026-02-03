-- Use legacy tag for fidget until rewrite is done
return {
    "j-hui/fidget.nvim",
    opts = {
        progress = {
            suppress_on_insert = true,
            ignore_done_already = true,
        }
    }
} -- Lsp status notifications
