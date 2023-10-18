return {
  {
    dependencies = {
      {
        'projekt0n/github-nvim-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
          require('github-theme').setup {
            options = {
              hide_end_of_buffer = true,
              -- italic,bold
              -- styles = {
              --   comments = 'NONE',
              --   functions = 'NONE',
              --   keywords = 'NONE',
              --   variables = 'NONE',
              --   conditionals = 'NONE',
              --   constants = 'NONE',
              --   numbers = 'NONE',
              --   operators = 'NONE',
              --   strings = 'NONE',
              --   types = 'NONE',
              -- },
            },
          }
        end,
      },
      {
        'sainnhe/edge',
      },
    },
    -- { 'd00h/nvim-rusticated' },

    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup {
        symbol = '',
        draw = {
          delay = 10,
        },
      }

      if vim.fn.filereadable '/tmp/day' == 1 then
        vim.cmd 'colorscheme github_light'
      else
        vim.cmd 'colorscheme edge'
      end
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
  --   end,
  -- },
  -- {
  --   'olivercederborg/poimandres.nvim',
  --   config = function()
  --     require('poimandres').setup {}
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
  -- },
}
