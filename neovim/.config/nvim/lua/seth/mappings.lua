vim.g.mapleader = " " -- Change leader to space which is easier to reach
vim.g.maplocalleader = ',' -- Change localleader to ,

vim.keymap.set('n', 'Q', '<nop>', { desc = 'no need for ex mode' })

vim.keymap.set('n', 'yy', '"+yy', { desc = 'system clipboard' })
vim.keymap.set('n', 'dd', '"+dd', { desc = 'system clipboard' })
vim.keymap.set('n', 'p', '"+gP', { desc = 'system clipboard' })

vim.keymap.set('n', '<C-c>', '"+yy', { desc = 'system clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'system clipboard' })
vim.keymap.set('n', '<C-x>', '"+dd', { desc = 'system clipboard' })
vim.keymap.set('v', '<C-x>', '"+d', { desc = 'system clipboard' })

vim.keymap.set('n', '<Right>', ':bnext<CR>', { desc = 'move to next buffer' })
vim.keymap.set('n', '<Left>', ':bprev<CR>', { desc = 'move to previous buffer' })
vim.keymap.set('n', '<leader>T', ':enew<CR>', { desc = 'open a new buffer' })
