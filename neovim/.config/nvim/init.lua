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

vim.opt.tabstop=8
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.mouse='a'
vim.opt.encoding='UTF-8'
vim.opt.laststatus=2
vim.opt.showtabline=2
vim.opt.backspace={'indent','eol','start'}
--syntax on
vim.opt.regexpengine=0
vim.opt.clipboard:append('unnamedplus')
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.lazyredraw = true
vim.opt.shortmess='FaWc'

vim.opt.foldmethod='syntax'
vim.opt.foldcolumn='1'
vim.opt.foldlevelstart=99


vim.g.python_host_prog = '/usr/bin/python2'
vim.g.python3_host_prog = '/usr/bin/python3'

vim.g.vimpath = vim.fn.fnamemodify(vim.fn.expand("$MYVIMRC"), ":p:h")


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
vim.cmd([[augroup numbertoggle
    let number_ftToIgnore = ['Trouble', 'vista', 'qf']
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if index(number_ftToIgnore, &ft) < 0 | set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * if index(number_ftToIgnore, &ft) < 0 | set norelativenumber number
augroup END]])

vim.cmd([[augroup rasi_css
    " set rasi filetypes to css
    autocmd BufRead,BufNewFile /*.rasi setf css
augroup end]])


-- Set colorscheme
require("challenger_deep")
vim.cmd([[if g:colors_name ==# 'challenger_deep'
    " These overrides were taken from https://github.com/skbolton/titan/blob/master/states/nvim/nvim/plugin/themes.vim
    hi DiffAdd guibg=#62d196 guifg=black
    hi DiffDelete guibg=#ff5458 guifg=black
    hi DiffChange guibg=#ffb378 guifg=black
    hi DiffText guibg=#ffe9aa guifg=black
    let g:challenger_deep_terminal_italics = 1
endif]])


vim.cmd([[exec 'source '  . g:vimpath . '/plugins.vim']])
require('impatient-config')
vim.cmd([[exec 'source '  . g:vimpath . '/mappings.vim']])

vim.opt.termguicolors = true

-- Better diff (https://vimways.org/2018/the-power-of-diff)
vim.opt.diffopt:append('algorithm:patience')
vim.opt.diffopt:append('indent-heuristic')

--" Convenient command to see the difference between the current buffer and the
--" file it was loaded from, thus the changes you made.
--" Only define it when not defined already.
--
vim.cmd([[if !exists(':DiffOrig')
    command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif]])


vim.cmd([[let g:default_path = escape(&path, '\ ') ]])


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

vim.cmd([[autocmd BufNewFile,BufRead *.inc set ft=asm]])

