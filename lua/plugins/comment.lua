return {
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
}
