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
vim.opt.winborder = 'rounded'

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
    ['neo-tree'] = true,
    ['qf'] = true
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

vim.api.nvim_set_hl(0, "QuickFixLine", {})

-- WARNING: Nvim >= 0.11: LSP
vim.lsp.enable({ 'clangd', 'rust_analyzer', 'pylsp', 'jsonls', 'lua_ls' })

-- NOTE: Update lsp capabilities with blink

local updated_capabilities = require('blink.cmp').get_lsp_capabilities()

-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
updated_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

vim.lsp.config('*', {
    capabilities = updated_capabilities
})

-- NOTE: setup autoformat
local augroup_format = vim.api.nvim_create_augroup("Custom LSP Format", {}) -- defaults to clear = true

local autocmd_format = function(async, filter)
    vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = 0,
        callback = function()
            vim.lsp.buf.format { async = async, filter = filter }
        end,
    })
end

local filetype_attach = setmetatable({
    python = function()
        autocmd_format(false)
    end,
    lua = function()
        autocmd_format(false)
    end,
    c = function()
        -- I want to use Ctags over the LSP stuff for PMD decomp since I
        -- also have assembly files with tags that are referenced.
        local current_dir = vim.fn.getcwd(-1, -1)
        local basename = vim.fs.basename(current_dir)
        --print(basename)
        if basename == "pmd-red" or basename == "pmd-sky" then
            vim.bo.tagfunc = ""
        end

        -- Register this custom command we get from Clangd LSP
        vim.keymap.set('n', '<leader>la', '<cmd>ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })
    end,
}, {
    __index = function()
        return function()
        end
    end,
})


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable()
        end

        -- Setup codelens for supported LSPs
        if client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = 0,
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
            })
        end

        local bufnr = vim.api.nvim_get_current_buf()

        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

        filetype_attach[filetype](client)
    end
})

-- Taken from @pseudometapseudo on Reddit
vim.api.nvim_create_user_command("LspCapabilities", function()
    local curBuf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients { bufnr = curBuf }

    for _, client in pairs(clients) do
        local capAsList = {}
        for key, value in pairs(client.server_capabilities) do
            if value and key:find("Provider") then
                local capability = key:gsub("Provider$", "")
                table.insert(capAsList, "- " .. capability)
            end
        end
        table.sort(capAsList) -- sorts alphabetically
        local msg = "# " .. client.name .. "\n" .. table.concat(capAsList, "\n")
        vim.notify(msg, vim.log.levels.TRACE, {
            on_open = function(win)
                local buf = vim.api.nvim_win_get_buf(win)
                vim.api.nvim_set_option_value("tiletype", "markdown", { buf = buf })
            end,
            timeout = 14000,
        })
        vim.fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
    end
end, {})

-- Noob coding from yours truly on a hex to decimal to stop using the internet just to figure these out
vim.api.nvim_create_user_command("HexCalc", function()
    local input = vim.fn.input('Enter value in hex: ')
    local new_s = string.gsub(input, "0x", "")
    local num = tonumber(new_s, 16)
    if num == nil then return end
    vim.print(" = " .. num)
end, {})

-- Enable treesitter
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'lua', 'rust', 'query', 'bash', 'make', 'arm', 'pory', 'poryscript' },
    callback = function() vim.treesitter.start() end,
})
