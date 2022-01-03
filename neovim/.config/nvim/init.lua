require('plugins')
require('keymappings')

-- Don't make searches case sensitive.
vim.api.nvim_set_option('ignorecase', true)

-- Use the system clipboard for yank(copy) and paste.
vim.api.nvim_set_option('clipboard', 'unnamedplus')
