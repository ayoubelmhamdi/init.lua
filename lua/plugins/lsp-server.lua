return {
    'neovim/nvim-lspconfig',
    -- event = 'LspAttach',
    dependencies = {
        { 'williamboman/mason.nvim', event = 'LspAttach' },
        { 'williamboman/mason-lspconfig.nvim', event = 'LspAttach' },
        { 'barreiroleo/ltex-extra.nvim', event = 'LspAttach' },
        { 'hrsh7th/nvim-cmp', event = 'LspAttach' }, -- for capability that used in lspconfig
        {
            'akinsho/flutter-tools.nvim',
            event = 'LspAttach',
            dependencies = {
                { 'nvim-lua/plenary.nvim' },
                { 'stevearc/dressing.nvim', lazy = true }, -- optional for vim.ui.select
            },
        },
    },
    config = function()
        require('custom.lsp-server')
    end
}
