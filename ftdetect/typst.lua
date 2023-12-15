local autocmd = vim.api.nvim_create_autocmd

-- FileTypes
autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.typ',
    command = 'set filetype=typst',
})
