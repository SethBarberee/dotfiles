vim.opt.textwidth = 78

if vim.fn.has('spell') and vim.opt.modifiable and not vim.opt.readonly then
    vim.opt.spell = true
end
