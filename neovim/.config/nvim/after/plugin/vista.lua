vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
vim.g.vista_sidebar_width = 50
vim.g.vista_default_executive = 'nvim_lsp'
vim.g.vista_finder_alternative_executives = 'ctags'
vim.g.vista_echo_cursor_strategy = 'both' -- floating_win and echo

-- Fallback to ctags for asm and vim
vim.g.vista_executive_for = {
    ['asm'] = 'ctags',
    ['arm'] = 'ctags'
}

-- Open if not opened and close if already opened
vim.keymap.set('n', '<C-T>', ':Vista!! <Enter>', { desc = 'toggle Vista' })
