--
--            _
-- _ ____   _(_)_ __ ___
--| '_ \ \ / / | '_ ` _ \
--| | | \ V /| | | | | | |
--|_| |_|\_/ |_|_| |_| |_|

vim.loader.enable()
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.number = true
vim.opt.confirm = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.timeoutlen = 200
vim.opt.updatetime = 100

-- Indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.swapfile = false
vim.opt.mouse = 'a'
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.shortmess = 'FaWc'
vim.opt.scrolloff = 8 -- keep at least 8 lines (based off @ThePrimeagen)

vim.opt.foldmethod = 'syntax'
vim.opt.foldcolumn = '1'
vim.opt.foldlevelstart = 99

vim.opt.signcolumn = 'auto:1' -- only keep one column to make things nicier
vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.spelllang = "en_us"

-- Vim Grep
-- NOTE: technially, we already have rg for telescope
-- but still guard, just in case
if vim.fn.executable('rg') then
    vim.opt.grepprg = "rg --vimgrep --hidden"
    vim.opt.grepformat = "%f:%l:%c:%m"
end

-- Providers
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.g.vimpath = vim.fn.fnamemodify(vim.env.MYVIMRC, ":p:h")

-- Create an augroup to group all of our commands
local group_id = vim.api.nvim_create_augroup("init.lua", {}) -- defaults to clear = true

--  When editing a file, always jump to the last known cursor position.
--  Don't do it when the position is invalid or when inside an event handler
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    group = group_id,
    callback = function()
        if vim.fn.line("'\"") >= 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd.normal { "g`\"", bang = true }
        end
    end
})

-- Line numbers
-- List of filetypes to ignore my relativenumber/number settings
local number_ftToIgnore = {
    ['help'] = true,
    ['Glance'] = true,
    ['Navbuddy'] = true,
    ['lazy'] = true,
    ['neo-tree'] = true
}

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
    pattern = { "*" },
    group = group_id,
    callback = function()
        -- NOTE: vista likes to use different filetype names so
        -- we just check to see if it contains vista
        if not number_ftToIgnore[vim.bo.filetype] and not string.find(vim.bo.filetype, 'vista') then
            vim.opt.relativenumber = true
        else
            vim.opt.number = false
            vim.opt.relativenumber = false
        end
    end
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    pattern = { "*" },
    group = group_id,
    callback = function()
        if not number_ftToIgnore[vim.bo.filetype] then
            vim.opt.relativenumber = false
            vim.opt.number = true
        end
    end
})

require('seth.diagnostic')
require('seth.mappings')

-- Load plugins w/ lazy package manager
require('seth.lazy')

-- Better diff (https://vimways.org/2018/the-power-of-diff)
-- vim.opt.diffopt:append('algorithm:patience')
vim.opt.diffopt:append('indent-heuristic')
vim.opt.diffopt:append('linematch:60')

-- Convenient command to see the difference between the current buffer and the
-- file it was loaded from, thus the changes you made.
-- Only define it when not defined already.
--
if vim.fn.exists(':DiffOrig') == 0 then
    local command = 'vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis| wincmd p | diffthis'
    vim.api.nvim_create_user_command('DiffOrig', command,
        { desc = 'Check difference between current buffer and file it was loaded from' })
end


vim.g.default_path = vim.fn.escape(vim.g.vimpath, '/')

-- Always add the current file's directory to the path and tags list if not
-- already there. Add it to the beginning to speed up searches.

vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = { "*" },
    group = group_id,
    callback = function()
        local tempPath = vim.fn.finddir('.git/..', vim.fn.expand('%:p:h') .. ';')
        vim.cmd.set("path-=" .. tempPath)
        vim.cmd.set("path-=" .. vim.g.default_path)
        vim.cmd.set("path^=" .. tempPath)
        vim.cmd.set("path^=" .. vim.g.default_path)
    end
})

-- Force set to my filetype to run my treesitter parser
vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = { "*.s" },
    group = group_id,
    callback = function()
        vim.opt.filetype = "arm"
    end
})
