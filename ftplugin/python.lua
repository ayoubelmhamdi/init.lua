local key = vim.keymap.set
local opt = { noremap = true, silent = true }

key('n', '<C-f>', "<cmd>lua require('ayoub.diff').toggle({ 'ruff', 'format', vim.fn.expand('%:p'), '--diff' }, 3)<cr>", opt)
key('n', '<C-c>', "<cmd>lua require('ayoub.diff').toggle({ 'ruff', 'check', vim.fn.expand('%:p'), '--diff' }, 3)<cr>", opt)

