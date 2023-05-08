return {
  -- file switcher
  'ThePrimeagen/harpoon',
  lazy = true,
  keys = {
    { '<C-e>', '<CMD> lua require("harpoon.ui").toggle_quick_menu()<CR>' },
    { '<leader>a', '<CMD> lua require("harpoon.mark").add_file()<CR>' },

    { '<leader>1', '<CMD> lua require("harpoon.ui").nav_file(1)<CR>' },
    { '<leader>2', '<CMD> lua require("harpoon.ui").nav_file(2)<CR>' },
    { '<leader>3', '<CMD> lua require("harpoon.ui").nav_file(3)<CR>' },
    { '<leader>4', '<CMD> lua require("harpoon.ui").nav_file(4)<CR>' },

    { '<leader>n', ' <cmd>:lua require("harpoon.ui").nav_next()<cr>' },
    { '<leader>p', ' <cmd>:lua require("harpoon.ui").nav_prev()<cr>' },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
}
