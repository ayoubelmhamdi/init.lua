return {
    'Vonr/align.nvim',
    branch = 'v2',
    lazy = true,
    init = function()
        vim.keymap.set('x', 'ga', function()
            require('align').align_to_char({
                regex = true,
                preview = false,
                length = 2,
            })
        end, { noremap = true, silent = true })
    end,
}
