local key = vim.keymap.set
local opt = { noremap = true, silent = true }

local ayoub = require('ayoub.diff')

local kinds = {
    ['full'] = 1,
    ['range'] = 2,
    ['diff'] = 3,
}

local commands = {
    ['ruff_format'] = { 'ruff', 'format', vim.fn.expand('%:p'), '--diff' },
    ['format_check'] = { 'ruff', 'check', vim.fn.expand('%:p'), '--diff' },
    ['echo'] = { 'echo', '-e', 'Hell\\nWord' },
}

key('n', '<C-f>', function() ayoub.toggle(commands['ruff_format'], kinds['diff']) end, opt)
key('n', '<C-c>', function() ayoub.toggle(commands['ruff_check'], kinds['diff']) end, opt)
key('v', '<C-f>', function() ayoub.toggle(commands['echo'], kinds['range']) end, opt)
