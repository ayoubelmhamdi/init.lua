return {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  cmd = 'Oil',
  config = function()
    require('oil').setup()
  end,
}
