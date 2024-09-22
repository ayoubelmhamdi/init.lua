return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.4',
    lazy = true,
    event = 'VeryLazy',
    cmd = 'Telescope',
    dependencies = {
        'cljoly/telescope-repo.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    -- config = function() require('custom.telescope') end,
}
