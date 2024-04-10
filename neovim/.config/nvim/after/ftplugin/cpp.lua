local basePath = vim.fn.finddir('.git/..', vim.fn.expand('%:p:h') .. ';')
vim.cmd.set("path+=" .. basePath .. "/include")
