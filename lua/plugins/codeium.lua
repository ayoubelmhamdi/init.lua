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
    vim.g.codeium_disable_bindings = 1

    vim.keymap.set('i', '<TAB>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<C-e>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<c-j>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<c-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<c-y>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  end,
}
