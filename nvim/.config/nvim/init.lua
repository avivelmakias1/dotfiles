-- Avoid Python provider detection hangs from the built-in python ftplugin.
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'config'
