return {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    keys = {
        {
            '<space>f',
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

    config = function(_, opts)
        require('conform.formatters.shfmt').args = { '-i', '4', '-filename', '$FILENAME' }
        require('conform').setup({
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'ruff_format', 'ruff_fix', 'isort' }, -- Conform will run multiple formatters sequentially
                javascript = { { 'prettierd', 'prettier' } }, -- Use a sub-list to run only the first available formatter
                css = { { 'prettierd', 'prettier' } },
                less = { { 'prettierd', 'prettier' } },
                scss = { { 'prettierd', 'prettier' } },
                html = { { 'prettierd', 'prettier' } },
                yaml = { { 'prettierd', 'prettier' } },
                markdown = { 'mdformat' },
                sh = { 'shfmt', 'shellcheck' },
                bash = { 'shfmt', 'shellcheck' },
                json = { 'fixjson', 'jq' },
                jsonc = { 'fixjson', 'jq' },
            },
        })
    end,
}
