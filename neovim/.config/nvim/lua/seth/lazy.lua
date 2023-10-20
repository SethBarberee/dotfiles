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
    dev = {
        path = "~/nvim-projects", -- repo for nvim projects
        fallback = true, -- use git when repo doesnt exist locally
    },
    ui = {
        border = "rounded",
    },
})
