return {
    'hrsh7th/nvim-cmp',
    after = 'lspkind-nvim',
    event = 'InsertEnter',
    dependencies = {
        { 'onsails/lspkind.nvim' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'L3MON4D3/LuaSnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        -- { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        -- {
        --     'Exafunction/codeium.nvim',
        --     config = function() require('codeium').setup({}) end,
        -- },
        {
            "zbirenbaum/copilot-cmp",
            dependencies = {'zbirenbaum/copilot.lua'},
            config = function()
                vim.defer_fn(function()
                    require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
                    require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
                end, 100)

            end,
            event = { "InsertEnter", "LspAttach" },
            fix_pairs = true,
        },
        {
            'rcarriga/cmp-dap',
            config = function()
                require('cmp').setup({
                    enabled = function() return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer() end,
                })

                require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
                    sources = {
                        { name = 'dap' },
                    },
                })
            end,
        },
        -- { 'mstanciu552/cmp-matlab' },
        -- Snippets
        -- { 'L3MON4D3/LuaSnip' },
        -- { 'rafamadriz/friendly-snippets' },
        --TODO test if After
        -- { 'neovim/nvim-lspconfig' },
        -- -- should swtich to https://github.com/kizza/cmp-rg-lsp
        -- thne create my own regex to grep all partener
        -- { 'lukas-reineke/cmp-rg' },
    },
    priority = 1,
    config = function()
        --if true then return end
        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        local cmp = require('cmp')
        local ok, lspkind = pcall(require, 'lspkind')
        if not ok then return end

        local sources = cmp.config.sources({
            { name = "copilot", group_index = 2 },
            -- { name = 'codeium' },
            { name = 'path' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp' },
            -- { name = 'nvim_lua' },
            -- { name = 'luasnip' },
        })

        local has_words_before = function()
            if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
        end


        local mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-u>'] = cmp.mapping.scroll_docs(4),
            ['<C-y>'] = cmp.mapping.abort(),
            ['<c-e>'] = cmp.mapping( cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, }), { 'i', 'c' }),
            ['<c-space>'] = cmp.mapping({
                i = cmp.mapping.complete(),
                c = function(
                    _ --[[fallback]]
                )
                    if cmp.visible() then
                        if not cmp.confirm({ select = true }) then return end
                    else
                        cmp.complete()
                    end
                end,
            }),
            -- ['<tab>'] = cmp.mapping( cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, }), { 'i', 'c' }),
            ["<Tab>"] = vim.schedule_wrap(function(fallback) if cmp.visible() and has_words_before() then cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }) else fallback() end end),
            -- Cody completion
            ['<c-a>'] = cmp.mapping.complete({
                config = {
                    sources = {
                        { name = 'cody' },
                    },
                },
            }),
            -- ['<up>'] = cmp.config.disable,
        }

        local sorting1 = {
            -- tj sort
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,

                -- copied from cmp-under, but I don't think I need the plugin for this.
                -- I might add some more of my own.
                function(entry1, entry2)
                    local _, entry1_under = entry1.completion_item.label:find('^_+')
                    local _, entry2_under = entry2.completion_item.label:find('^_+')
                    entry1_under = entry1_under or 0
                    entry2_under = entry2_under or 0
                    if entry1_under > entry2_under then
                        return false
                    elseif entry1_under < entry2_under then
                        return true
                    end
                end,

                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        }
        local sorting = {
            priority_weight = 2,
            comparators = {
                require("copilot_cmp.comparators").prioritize,
                cmp.config.compare.offset,
                -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        }


        local formatting = {
            format = lspkind.cmp_format({
                with_text = true,
                menu = {
                    copilot = '[Cop]',
                    buffer = '[buf]',
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[lua]',
                    path = '[path]',
                    lusasnip = '[snip]',
                },
                -- mode = 'text_symbol',
                maxwidth = 80,
            }),
        }
        ---------------------------- CMP SETUP -------------------------------------
        cmp.setup({
            snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
            sources = sources,
            formatting = formatting,
            mapping = mapping,
            sorting = sorting,
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            experimental = {
                native_menu = false,
                ghost_text = true,
            },
        })

        ---------------------------- cmdline -------------------------------------
        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = 'buffer' },
            }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
            }),
        })
    end,
}
