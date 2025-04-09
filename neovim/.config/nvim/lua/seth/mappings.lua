vim.g.mapleader = " "      -- Change leader to space which is easier to reach
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

-- NOTE: more lsp mappings that I like. Some are handled by glances
vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, { desc = 'lsp-code_action' })
vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, { desc = 'lsp-declaration' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'lsp-formatting' })
vim.keymap.set('n', '<leader>lI', "<cmd>LspCapabilities<cr>", { desc = 'lsp-capabilities' })
vim.keymap.set('n', '<leader><c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'lsp-sighelp' })
vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename, { desc = 'lsp-rename' })
vim.keymap.set('n', '<leader>l0', vim.lsp.buf.document_symbol, { desc = 'lsp-docsymbol' })
vim.keymap.set('n', '<leader>lW', vim.lsp.buf.workspace_symbol, { desc = 'lsp-workspacesymbol' })
vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { desc = 'lsp-codelens-run' })
