require 'ayoub'

vim.keymap.set('n', '<space>s', function()
  package.loaded.gg = nil
  -- vim.cmd 'w'
  R 'gg'
  require('gg').view_function()
end, {})

vim.keymap.set('n', '<space>e', function()
  require('gg').view_function()
end, {})

require('Comment').setup {}
