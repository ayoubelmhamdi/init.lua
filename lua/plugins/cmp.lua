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
    --         --     'zbirenbaum/copilot-cmp',
    --         --     dependencies = {'zbirenbaum/copilot.lua'},
    --         --     event = { 'InsertEnter', 'LspAttach' },
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
        dependencies = {
            'rafamadriz/friendly-snippets',
            'Kaiser-Yang/blink-cmp-dictionary',
            {
                
                "Exafunction/codeium.nvim",
                dependencies = {
                    "saghen/blink.compat",
                    opts = { enable_events = true }
                },

                init = function()
                    vim.g.codeium_enabled = 0
                    vim.g.codeium_disable_bindings = 1
                    vim.g.codeium_idle_delay = 1500
                end,
                config = function()
                    -- require('codeium').setup({})
                    -- vim.keymap.set("i", "<A-;>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
                    -- vim.keymap.set("i", "<A-;>", function() return vim.fn['codeium#CycleCompletions'](1)  end, { expr = true, silent = true })
                    -- vim.keymap.set("i", "<A-;>", function() return  vim.fn["codeium#Accept"]()  end, { expr = true, silent = true })
                end,

            },
            -- 'giuxtaposition/blink-cmp-copilot',
            -- {
            --     'zbirenbaum/copilot.lua',
            --     --  export GH_COPILOT_TOKEN="$(gh auth token)"
            --     --  :Copilot auth signin
            --     cmd = "Copilot",
            --     event = "InsertEnter",
            --     opts = {
            --         suggestion = { enabled = false },
            --         panel = {
            --             enabled = true,
            --             auto_refresh = true,
            --         },
            --     },
            -- },
        },
        version = 'v1.*',
        build = 'cargo build --release',
        opts = {
            cmdline = { enabled = true },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            keymap = {
                preset = 'default',
                ['<C-y>'] = { 'hide' },
                ['<C-e>'] = { 'select_and_accept' },
                ['<C-j>'] = { 'snippet_forward' },
                ['<C-k>'] = { 'snippet_backward' },
            },
            completion = {
                menu = {
                    auto_show = false,
                    border = 'rounded',
                    draw = {
                        columns = {
                            { 'label', 'label_description', gap = 1 },
                            { 'kind_icon', 'kind', gap = 1 },
                        },
                    },
                },
                documentation = {
                    auto_show = false,
                    window = { border = 'rounded' },
                },
                ghost_text = { enabled = true },
                list = {
                    selection = { preselect = true, auto_insert = true },
                },
            }, -- end completion
            sources = {
                -- 'copilot', 'omni',
                default = { 'lsp', 'path', 'snippets', 'buffer', 'dictionary', 'cmdline', 'codeium' },
                providers = {
                    lsp = {
                        name = 'LSP',
                        module = 'blink.cmp.sources.lsp',
                        opts = {}, -- Passed to the source directly, varies by source
                        --  NOTE: All of these options may be functions to get dynamic behavior
                        --  NOTE: See the type definitions for more information
                        enabled = true, -- Whether or not to enable the provider
                        async = false, -- Whether we should wait for the provider to return before showing the completions
                        timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
                        transform_items = nil, -- Function to transform the items before they're returned
                        should_show_items = true, -- Whether or not to show the items
                        max_items = nil, -- Maximum number of items to display in the menu
                        min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
                        -- If this provider returns 0 items, it will fallback to these providers.
                        -- If multiple providers fallback to the same provider, all the providers must return 0 items for it to fallback
                        fallbacks = {},
                        score_offset = 0, -- Boost/penalize the score of the items
                        override = nil, -- Override the source's functions
                    },
                    -- copilot = {
                    --     name = 'Copilot',
                    --     module = 'blink-cmp-copilot',
                    --     score_offset = 100,
                    --     async = true,
                    --     transform_items = function(_, items)
                    --         local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
                    --         local kind_idx = #CompletionItemKind + 1
                    --         CompletionItemKind[kind_idx] = 'Copilot'
                    --         for _, item in ipairs(items) do
                    --             item.kind = kind_idx
                    --         end
                    --         return items
                    --     end,
                    -- },
					codeium = {
						name = "codeium", -- IMPORTANT: use the same name as you would for nvim-cmp
						module = "blink.compat.source",
                        -- module = 'codeium.blink',
                        async = true,
					},
                    dictionary = {
                        module = 'blink-cmp-dictionary',
                        name = 'Dict',
                        -- Make sure this is at least 2.
                        -- 3 is recommended
                        min_keyword_length = 3,
                        opts = {
                            dictionary_directories = {
                                vim.fn.expand('/usr/share/wordnet'),
                                vim.fn.expand('~/.config/nvim-ayoub/spell'),
                            },
                            -- dictionary_files = { },
                        },
                    },
                },
            }, -- end sources
        },
    },
}
