return {
  'ayoubelmhamdi/vf.nvim',
  config = function()
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      pattern = { '*.rs', '*.lua' },
      callback = function()
        R 'vf'
        vim.cmd [[silent! lua require("vf").view_function()]]
      end,
    })
  end,
}
