-- Set up my telescope settings for each builtin below

local seth_telescope = {}

function seth_telescope.buffer_grep()
    local opts = require("telescope.themes").get_ivy { previewer = false }
    require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function seth_telescope.find_files()
    local opts = require("telescope.themes").get_ivy { hidden = true }
    require("telescope.builtin").find_files(opts)
end

function seth_telescope.help_tags()
    local opts = require("telescope.themes").get_ivy {}
    require("telescope.builtin").help_tags(opts)
end

function seth_telescope.live_grep()
    local opts = require("telescope.themes").get_ivy {}
    require("telescope.builtin").live_grep(opts)
end

function seth_telescope.lsp_references()
    local opts = require("telescope.themes").get_ivy {}
    require("telescope.builtin").lsp_references(opts)
end

function seth_telescope.main()
    local opts = require("telescope.themes").get_ivy {}
    require("telescope.builtin").builtin(opts)
end


function seth_telescope.tags()
    local opts = require("telescope.themes").get_ivy {}
    require("telescope.builtin").tags(opts)
end

return seth_telescope
