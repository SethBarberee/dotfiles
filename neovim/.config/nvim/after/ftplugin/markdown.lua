vim.opt.textwidth = 78

if vim.fn.has('spell') then
    if vim.opt.modifiable and not vim.opt.readonly then
        vim.opt.spelllang = 'en_us'
    end

    -- TODO: check this sometime
    -- if vim.fn.expand('%:t') == 'README.md' then
    --     vim.opt.spellcapcheck
    -- end
end
