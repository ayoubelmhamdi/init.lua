return {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    ft = {      'lua', 'python', 'javascript', 'css', 'html', 'yaml', 'markdown', 'sh', 'bash', 'json', 'jsonc' },
    keys = {
        {'gq'},
        {
            '<space>fc',
            mode = { 'n', 'v' },
            function()
                require('conform').format({ async = true, lsp_fallback = true }, function(err)
                    if err then
                        print(err)
                    else
                        print('Formatted')
                    end
                end)
            end,
        },
    },
    init = function()
        -- If you want the formatexpr (like gq), here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,

    config = function()
        require('custom.conform')
    end,
}
