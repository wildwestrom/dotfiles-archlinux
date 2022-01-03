local g = vim.g

g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<space>', '<NOP>', { noremap = true, silent = true })

print(vim.inspect(vim.g.mapleader))
