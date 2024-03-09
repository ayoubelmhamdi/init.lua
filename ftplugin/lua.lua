local key = vim.keymap.set
local opt = { noremap = true, silent = true }

local control = require('ayoub.control')
local kinds = control.kinds

local commands = {
    stylua = { 'stylua', '-s', '--check', '--output-format', 'Unified'},
    echo = { 'echo', '-e', 'Hell\\nWord' },
}

key('n', '<C-f>', function() control.toggle(kinds['diff'], commands['stylua']) end, opt)
key('v', '<C-f>', function() control.toggle(kinds['range'], commands['echo']) end, opt)
