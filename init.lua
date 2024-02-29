require('ayoub.set')
require('ayoub.remap')
require('ayoub.autocmd')
require('ayoub.lazy')

vim.g.asmsyntax = 'nasm'
-- Disable Default Vim Plugins
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_spec = 0
vim.g.loaded_syncolor = 0

local key = vim.keymap.set
key('n', '<space>r', '<cmd>lua R("vmath")<cr>', { noremap = true, silent = true })
key('n', '<space>m', '<cmd>lua R("vmath")<cr>:lua require("vmath").print_function_info()<cr>', { noremap = true, silent = true })
