return {
  'jcdickinson/codeium.nvim',
  event = 'VeryLazy',
  ft = {'dart', 'c','python'},
  dependencies = {
    {
      'jcdickinson/http.nvim',
      build = 'cargo build --workspace --release',
    },
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require('codeium').setup {}
  end,
}
