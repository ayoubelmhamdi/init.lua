return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
        { 'lewis6991/spellsitter.nvim' },
        { 'David-Kunz/treesitter-unit' },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'p00f/nvim-ts-rainbow' },
        -- { 'filNaj/tree-setter' },
    },
    build = ':TSUpdate',
    --
    config = function()
        require('custom.treesitter')
    end,
}
