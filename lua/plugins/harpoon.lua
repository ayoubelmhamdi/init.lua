return { -- file switcher
  'ThePrimeagen/harpoon',
  lazy = true,
  keys = {
    { '<leader>a', '<CMD> lua require("harpoon.mark").add_file() <CR>', desc = 'add current file' },
    { '<C-e>', '<CMD> lua require("harpoon.ui").toggle_quick_menu() <CR>' },
    { '<leader>1', '<CMD> lua require("harpoon.ui").nav_file(1) <CR>' },
    { '<leader>2', '<CMD> lua require("harpoon.ui").nav_file(2) <CR>' },
    { '<leader>3', '<CMD> lua require("harpoon.ui").nav_file(3) <CR>' },
    { '<leader>4', '<CMD> lua require("harpoon.ui").nav_file(4) <CR>' },
    { '<leader>at', '<CMD> vsplit lua require("harpoon.mark").get_marked_file(1).filename <CR>' },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('telescope').load_extension 'harpoon'
  end,
}
