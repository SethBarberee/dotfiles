vim.g.mkdp_auto_start = 1

vim.g.mkdp_browser = 'firefox'

return {
    'iamcco/markdown-preview.nvim',
    ft = "markdown",
    build = function()
        vim.fn["mkdp#util#install"]()
    end
}
