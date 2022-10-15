
-- Taken from @gpanders
-- https://github.com/gpanders/dotfiles/blob/master/.config/nvim/filetype.lua 
vim.filetype.add({
    extension = {
        h = function()
            -- Use a lazy heuristic that #including a C++ header means it's a
            -- C++ header
            if vim.fn.search("\\C^#include <[^>.]\\+>$", "nw") ~= 0 then
                return "cpp"
            end
            return "c"
        end,
        inc = 'asm', -- for PMD Red data files
    },
    --pattern = {
    --    ["*.inc"] = "asm",
    --},
})
