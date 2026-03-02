-- Use nvim-lspconfig and add some settings
vim.lsp.config('clangd', {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "-j=8",
        "--malloc-trim",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--limit-results=0",
        "--enable-config",
    },
    init_options = { clangdFileStatus = true, },
})
