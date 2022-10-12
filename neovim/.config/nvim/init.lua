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

vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.mouse = 'a'
vim.opt.encoding = 'UTF-8'
vim.opt.laststatus = 3 -- I've finally converted to global statusline
vim.opt.showtabline = 2
vim.opt.backspace = { 'indent', 'eol', 'start' }
--syntax on
vim.opt.regexpengine = 0
vim.opt.clipboard:append('unnamedplus')
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.lazyredraw = true
vim.opt.shortmess = 'FaWc'

vim.opt.foldmethod = 'syntax'
vim.opt.foldcolumn = '1'
vim.opt.foldlevelstart = 99

vim.opt.signcolumn = 'auto:3'

vim.g.python_host_prog = '/usr/bin/python2'
vim.g.python3_host_prog = '/usr/bin/python3'

vim.g.vimpath = vim.fn.fnamemodify(vim.env.MYVIMRC, ":p:h")

-- Put these in an autocmd group, so that we can delete them easily.
vim.cmd([[augroup vimrcEx
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif

    " Close any automatically opened scratch-buffers 
    " " once completion popup the is closed
    "autocmd CompleteDone * pclose

augroup END]])

-- Line numbers
-- List of filetypes to ignore my relativenumber/number settings
local number_ftToIgnore = {'Trouble', 'vista', 'vista_kind', 'qf'};

-- check if the filetype is in my ignore list
local function in_ignoreList(filetype)
    for _, value in pairs(number_ftToIgnore) do
        if value == filetype then
            return true
        end
    end
    return false
end

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
    pattern = {"*"},
    callback = function()
        if not in_ignoreList(vim.bo.filetype) then
            vim.opt.relativenumber = true
        else
            vim.opt.number = false
            vim.opt.relativenumber = false
        end
    end
})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
    pattern = {"*"},
    callback = function()
        if not in_ignoreList(vim.bo.filetype) then
            vim.opt.relativenumber = false
            vim.opt.number = true
        end
    end
})

-- Set colorscheme
--vim.opt.termguicolors = true -- already set by colorscheme
require('seth.challenger_deep')

require('seth.mappings')
require('seth.plugins')
require('seth.impatient-config')

-- Better diff (https://vimways.org/2018/the-power-of-diff)
vim.opt.diffopt:append('algorithm:patience')
vim.opt.diffopt:append('indent-heuristic')

-- Convenient command to see the difference between the current buffer and the
-- file it was loaded from, thus the changes you made.
-- Only define it when not defined already.
--
if vim.fn.exists(':DiffOrig') == 0 then
    vim.cmd([[
        command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                    \ | wincmd p | diffthis
    ]])
end


vim.g.default_path = vim.fn.escape(vim.g.path, '\\ ')

-- Always add the current file's directory to the path and tags list if not
-- already there. Add it to the beginning to speed up searches.
--
vim.cmd([[autocmd BufRead *
      \ let s:tempPath=finddir('.git/..', expand('%:p:h').';') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".g:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".g:default_path]])

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

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.inc"},
    callback = function()
        vim.bo.filetype = 'asm'
    end
})
