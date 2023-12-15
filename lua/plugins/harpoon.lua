return {
    -- file switcher
    'ThePrimeagen/harpoon',
    lazy = true,
    keys = {
        { '<c-e>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>' },
        { '<leader>a', '<cmd>lua require("harpoon.mark").add_file()<cr>' },

        { '<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>' },
        { '<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>' },
        { '<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>' },
        { '<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>' },

        { '<leader>n', ' <cmd>lua require("harpoon.ui").nav_next()<cr>' },
        { '<leader>p', ' <cmd>lua require("harpoon.ui").nav_prev()<cr>' },
    },
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim',
    },
}
