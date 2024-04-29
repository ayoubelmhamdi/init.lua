return {
    { 'nvim-lua/plenary.nvim' },
    { 'folke/lazy.nvim', tag = 'stable' },

    -- Git
    --  { 'mbbill/undotree' },
    -- { 'tpope/vim-fugitive' },
    -- { 'airblade/vim-rooter', event = 'VeryLazy' },
    -- Basic
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function()
            require('Comment').setup({
                ignore = '^$',
            })

            local ft = require('Comment.ft')
            ft({ 'typst' }, ft.get('c'))
            ft.nasm = ';%s'
        end,
    },
    { 'jghauser/mkdir.nvim', event = 'VeryLazy' },
    -- { 'fedepujol/move.nvim' },
    -- { 'oberblastmeister/zoom.nvim' },
    -- Test
    -- { 'folke/zen-mode.nvim' },
    -- { 'github/copilot.vim' },
    -- { 'yazgoo/vmux' },
    { 'nyngwang/suave.lua', event = 'VeryLazy' },
    -- Localy
    -- { '/data/projects/lua/gg.nvim' },
}
