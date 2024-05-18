return {
    'hrsh7th/nvim-cmp',
    after = 'lspkind-nvim',
    event = 'InsertEnter',
    dependencies = {
        { 'onsails/lspkind.nvim' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'rcarriga/cmp-dap' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'L3MON4D3/LuaSnip' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        -- {
        --     'Exafunction/codeium.nvim',
        --     config = function() require('codeium').setup({}) end,
        -- },
        {
            "zbirenbaum/copilot-cmp",
            dependencies = {'zbirenbaum/copilot.lua'},
            event = { "InsertEnter", "LspAttach" },
            fix_pairs = true,
        },
    },
    priority = 1,
    config = function()
        require('custom.completion')
    end,
}
