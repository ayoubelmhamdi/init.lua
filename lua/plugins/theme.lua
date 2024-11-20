return {
    'echasnovski/mini.indentscope',
    version = false,
    dependencies = {
        -- 'ellisonleao/gruvbox.nvim',
        'blazkowolf/gruber-darker.nvim',
        -- {
        --     'projekt0n/github-nvim-theme',
        --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
        --     priority = 1000, -- make sure to load this before all the other start plugins
        -- },
        --  'sainnhe/edge',
        --  'd00h/nvim-rusticated',
    },
    config = function() require('custom.theme') end,
}
