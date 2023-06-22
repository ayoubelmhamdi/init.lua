return {
  {
    'sainnhe/edge',
    config = function()
      vim.cmd 'colorscheme edge'
    end,
  },
  -- {
  --   'd00h/nvim-rusticated',
  --   config = function()
  --     vim.cmd 'colorscheme rusticated'
  --   end,
  -- },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup {
        symbol = '',
        draw = {
          delay = 10,
        },
      }
    end,
  },
  -- {
  --   'olimorris/onedarkpro.nvim',
  --   priority = 1000, -- Ensure it loads first
  --   config = function()
  --     require('onedarkpro').setup {
  --       -- options = {
  --       --   transparency = true,
  --       -- },
  --       styles = {
  --         types = 'NONE',
  --         methods = 'bold',
  --         numbers = 'bold',
  --         strings = 'bold,italic',
  --         comments = 'bold,italic',
  --         keywords = 'bold,italic',
  --         constants = 'NONE',
  --         functions = 'bold,italic',
  --         operators = 'NONE',
  --         variables = 'NONE',
  --         parameters = 'NONE',
  --         conditionals = 'italic',
  --         virtual_text = 'NONE',
  --       },
  --     }
  --     vim.cmd 'colorscheme onedark'
  --   end,
  -- },
  -- {
  --   'olivercederborg/poimandres.nvim',
  --   config = function()
  --     require('poimandres').setup {}
  --     vim.cmd 'colorscheme poimandres'
  --   end,
  -- },
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
  --   'ellisonleao/gruvbox.nvim',
  --   config = function()
  --     vim.cmd.colorscheme 'gruvbox'
  --   end,
  -- },
}
