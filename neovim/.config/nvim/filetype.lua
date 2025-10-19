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
        inc = 'arm', -- for PMD Red data files
        pory = 'poryscript',
        jsonschema = 'json',
        qml = 'qml',
    },
    pattern = {
        ["ld_script.txt"] = "ld",
        ["sym_ewram.txt"] = "ld",
        ["sym_ewram2.txt"] = "ld",
        ["sym_iwram.txt"] = "ld",
    },
})
