require('plugins')
require('keymappings')

-- Don't make searches case sensitive.
vim.o.ignorecase = true

-- Use the system clipboard for yank(copy) and paste.
vim.o.clipboard = 'unnamedplus'

-- Make sure tabs are 4 spaces
-- To convert old tabs to spaces, use :retab
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
