return {
  'chipsenkbeil/distant.nvim',
  -- version = '0.1.2',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim' },
  },
  config = function()
    require('distant').setup {
      ['*'] = vim.tbl_extend(
        'force',
        require('distant.settings').chip_default(),
        { mode = 'ssh' } -- use SSH mode by default
      ),
    }
  end,
}
