local key = vim.keymap.set
local opt = { noremap = true, silent = true }

local control = require('ayoub.control')
local kinds = control.kinds
local parent_buf = control.parent_buf


local commands = {
    ruff_format = { 'ruff', 'format', '--diff' },
    ruff_check = { 'ruff', 'check', '--diff' },
    echo = { 'echo', '-e', 'Hell\\nWord' },
}

key('n', '<C-f>', function() control.toggle(kinds['diff'], commands['ruff_format']) end, opt)
key('n', '<C-c>', function() control.toggle(kinds['diff'], commands['ruff_check']) end, opt)
key('v', '<C-f>', function() control.toggle(kinds['range'], commands['echo']) end, opt)
