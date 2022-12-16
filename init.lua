require 'ayoub'

vim.keymap.set('n', '<space>s', function()
  package.loaded.gg = nil
  vim.cmd 'w'
  require('gg').test()
end, {})
