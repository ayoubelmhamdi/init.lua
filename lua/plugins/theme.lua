return {
  -- Theme
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup {
        symbol = '',
      }
    end,
  },
  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   config = function()
  --     vim.opt.list = true
  --     vim.opt.listchars:append "space:⋅"
  --     vim.cmd [[
  --       hi Indent1 guifg=#101010 guibg=NONE gui=nocombine
  --       hi Indent2 guifg=#101010 guibg=NONE gui=nocombine
  --       hi Indent3 guifg=#101010 guibg=NONE gui=nocombine
  --       hi Indent4 guifg=#101010 guibg=NONE gui=nocombine
  --       hi Indent5 guifg=#101010 guibg=NONE gui=nocombine
  --       hi Indent6 guifg=#101010 guibg=NONE gui=nocombine
  --   ]]
  --
  --     require('indent_blankline').setup {
  --       -- show_end_of_line = true,
  --       space_char_blankline = " ",
  --       char_highlight_list = {
  --         'Indent1',
  --         'Indent2',
  --         'Indent3',
  --         'Indent4',
  --         'Indent5',
  --         'Indent6',
  --       },
  --     }
  --   end,
  -- },
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
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
}
