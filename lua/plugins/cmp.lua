return {
    -- {
    --     'hrsh7th/nvim-cmp',
    --     after = 'lspkind-nvim',
    --     event = 'InsertEnter',
    --     dependencies = {
    --         { 'onsails/lspkind.nvim' },
    --         { 'hrsh7th/cmp-cmdline' },
    --         { 'hrsh7th/cmp-path' },
    --         { 'hrsh7th/cmp-buffer' },
    --         { 'rcarriga/cmp-dap' },
    --         { 'hrsh7th/cmp-nvim-lsp' },
    --         { 'saadparwaiz1/cmp_luasnip' },
    --         { 'L3MON4D3/LuaSnip' },
    --         { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    --         -- {
    --         --     'Exafunction/codeium.nvim',
    --         --     config = function() require('codeium').setup({}) end,
    --         -- },
    --         -- {
    --         --     "zbirenbaum/copilot-cmp",
    --         --     dependencies = {'zbirenbaum/copilot.lua'},
    --         --     event = { "InsertEnter", "LspAttach" },
    --         --     fix_pairs = true,
    --         -- },
    --     },
    --     priority = 1,
    --     config = function()
    --         -- require('custom.completion')
    --     end,
    -- },
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- dependencies = 'rafamadriz/friendly-snippets',
        version = 'v0.*',
        build = 'cargo build --release',
        opts = {
            highlight = {
                use_nvim_cmp_as_default = true,
            },
            keymap = {
                preset = 'default',
                -- show, hide, accept, select_and_accept, select_prev, select_next, show_documentation, hide_documentation,
                --   scroll_documentation_up, scroll_documentation_down, snippet_forward, snippet_backward, fallback

                ['<C-Y>'] = { 'hide' },
                ['<C-E>'] = { 'select_and_accept' },
                ['<C-J>'] = { 'snippet_forward' },
                ['<C-K>'] = { 'snippet_backward' },
            },
            nerd_font_variant = 'normal',
            -- accept = { auto_brackets = { enabled = true } }
            -- trigger = { signature_help = { enabled = true } }
            kind_icons = {
                Text = '',
                Method = '',
                Function = '',
                Constructor = '',

                Field = '',
                Variable = '',
                Property = '',

                Class = '',
                Interface = '',
                Struct = '',
                Module = '',

                Unit = '',
                Value = '',
                Enum = '',
                EnumMember = '',

                Keyword = '',
                Constant = '',

                Snippet = '',
                Color = '',
                File = '',
                Reference = '',
                Folder = '',
                Event = '',
                Operator = '',
                TypeParameter = '',
            },
        },
    },
}
