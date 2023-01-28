vim.g.mapleader = " " -- Change leader to space which is easier to reach
vim.g.maplocalleader = ',' -- Change localleader to ,

vim.keymap.set('n', 'Q', '<nop>', { desc = 'no need for ex mode' })

vim.keymap.set('n', 'yy', '"+yy', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', 'dd', '"+dd', { desc = 'Delete and copy to system clipboard' })
vim.keymap.set('n', 'p', '"+gP', { desc = 'Paste from system clipboard' })


-- From @ThePrimeagan: autocenter the next match on the screen
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")

vim.keymap.set('n', '<C-c>', '"+yy', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<C-x>', '"+dd', { desc = 'Cut to system clipboard' })
vim.keymap.set('v', '<C-x>', '"+d', { desc = 'Cut to system clipboard' })

vim.keymap.set('n', '<Right>', ':bnext<CR>', { desc = 'move to next buffer' })
vim.keymap.set('n', '<Left>', ':bprev<CR>', { desc = 'move to previous buffer' })
vim.keymap.set('n', '<leader>T', ':enew<CR>', { desc = 'open a new buffer' })
