local lazypath = vim.fn.stdpath("data") .. "/plugged/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)


require("lazy").setup("seth.plugins", {
    root = vim.fn.stdpath("data") .. "/plugged",
    install = { colorscheme = { "challenger_deep", "habamax" } },
    ui = {
        border = "rounded",
    },
    debug = true,
})
-- For nvim-cmp
vim.g.completeopt = { 'menu', 'menuone', 'noselect' }

-- TODO move these to seth.plugins so we can abuse lua cache for lazy
require('seth.colorizer')
require('seth.lsp')
require('seth.cmp')
require('seth.treesitter')
require('seth.which_key')
require('seth.indent-blankline')
require('seth.fidget')
require('seth.gps')
require('seth.dap')
require('seth.lualine')
require('seth.navic')
require('seth.diagnostic')
require('seth.telescope')
require('seth.gitsigns')
require('seth.comment')
require('seth.ufo')
