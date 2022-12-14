require("ayoub")

vim.keymap.set('n', '<space>s', function()
  package.loaded.ff = nil
  vim.cmd 'w'
  require('ff').test()
end, {})
