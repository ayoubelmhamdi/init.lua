return {
  -- 'jcdickinson/codeium.nvim',
  'Exafunction/codeium.vim',
  event = 'VeryLazy',
  ft = { 'dart', 'c', 'python' },
  -- dependencies = {
  --   {
  --     'jcdickinson/http.nvim',
  --     build = 'cargo build --workspace --release',
  --   },
  --   'nvim-lua/plenary.nvim',
  --   'hrsh7th/nvim-cmp',
  -- },
  config = function()
    -- require('codeium').setup {}
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<C-g>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true })
    vim.keymap.set('i', '<c-;>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true })
    vim.keymap.set('i', '<c-,>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true })
    vim.keymap.set('i', '<c-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true })
  end,
}
