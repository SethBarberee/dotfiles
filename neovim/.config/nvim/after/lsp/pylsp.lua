-- Use nvim-lspconfig and add some settings
vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'E261' },
                    maxLineLength = 100,
                }
            }
        }
    }
})
