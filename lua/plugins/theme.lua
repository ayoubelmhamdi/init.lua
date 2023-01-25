return {
  -- Theme
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.cmd [[
        hi Indent1 guifg=#3A2A1A guibg=NONE
        hi Indent2 guifg=#3A2A1A guibg=NONE
        hi Indent3 guifg=#3A2A1A guibg=NONE
        hi Indent4 guifg=#3A2A1A guibg=NONE
        hi Indent5 guifg=#3A2A1A guibg=NONE
        hi Indent6 guifg=#3A2A1A guibg=NONE
    ]]

      require('indent_blankline').setup {
        show_end_of_line = true,
        char_highlight_list = {
          'Indent1',
          'Indent2',
          'Indent3',
          'Indent4',
          'Indent5',
          'Indent6',
        },
      }
    end,
  },
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   config = function()
  --     vim.cmd.colorscheme 'rose-pine'
  --
  --     vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  --     vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  --   end,
  -- },
  -- {
  --   'eddyekofo94/gruvbox-flat.nvim',
  --   config = function()
  --     vim.cmd.colorscheme 'gruvbox-flat'
  --     -- vim.g.gruvbox_flat_style = 'dark'
  --   end,
  -- },
  {"ellisonleao/gruvbox.nvim", config = function ()
      vim.cmd.colorscheme 'gruvbox'
  end}
}
