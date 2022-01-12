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

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Encoding
vim.o.encoding = 'utf8'

-- Leader Keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Mouse
vim.o.mouse = 'a'
