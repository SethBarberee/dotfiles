--
--            _
-- _ ____   _(_)_ __ ___
--| '_ \ \ / / | '_ ` _ \
--| | | \ V /| | | | | | |
--|_| |_|\_/ |_|_| |_| |_|

vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.showcmd = true
vim.opt.number = true
vim.opt.confirm = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.showmode = false
vim.opt.timeoutlen = 200
vim.opt.updatetime = 100

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.mouse = 'a'
vim.opt.laststatus = 3 -- I've finally converted to global statusline
vim.opt.showtabline = 2
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.shortmess = 'FaWc'
vim.opt.scrolloff = 8 -- keep at least 8 lines (based off @ThePrimeagen)

vim.opt.foldmethod = 'syntax'
vim.opt.foldcolumn = '1'
vim.opt.foldlevelstart = 99

vim.opt.signcolumn = 'auto:3'
vim.opt.completeopt = "menu,menuone,noselect"

vim.g.python3_host_prog = '/usr/bin/python3'

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
    ['vista'] = true,
    ['vista_kind'] = true,
    ['help'] = true,
}

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
    pattern = { "*" },
    group = group_id,
    callback = function()
        if not number_ftToIgnore[vim.bo.filetype] then
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
vim.cmd.colorscheme "challenger_deep"

-- Better diff (https://vimways.org/2018/the-power-of-diff)
vim.opt.diffopt:append('algorithm:patience')
vim.opt.diffopt:append('indent-heuristic')

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


--"" TODO figure out how to move this
vim.g.gutentags_ctags_exclude = {
    '*.git', '*.svg', '*.hg',
    '*/tests/*',
    'build',
    'dist',
    '*sites/*/files/*',
    'bin',
    'node_modules',
    'bower_components',
    'cache',
    'compiled',
    'docs',
    'example',
    'bundle',
    'vendor',
    '*.md',
    '*-lock.json',
    '*.lock',
    '*bundle*.js',
    '*build*.js',
    '.*rc*',
    '*.json',
    '*.min.*',
    '*.map',
    '*.bak',
    '*.zip',
    '*.pyc',
    '*.class',
    '*.sln',
    '*.Master',
    '*.csproj',
    '*.tmp',
    '*.csproj.user',
    '*.cache',
    '*.ccls-cache',
    '*.pdb',
    'tags*',
    'cscope.*',
    '*.css',
    '*.less',
    '*.scss',
    '*.exe', '*.dll',
    '*.mp3', '*.ogg', '*.flac',
    '*.swp', '*.swo',
    '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
    '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
    '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
}

vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/vim/ctags/')
--
--" a -> acccess or export of class members
--" i -> inheritance information
--" l -> language of input file containing tag
--" m -> implementation information
--" n -> line number of tag definition
--" S -> Signature of routine (prototype or parameter list)
--
vim.g.gutentags_ctags_extra_args = {
    '--tag-relative=yes',
    '--fields=+ailmnS',
}
