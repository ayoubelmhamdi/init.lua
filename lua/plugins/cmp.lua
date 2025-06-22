return {
    'saghen/blink.cmp',
    -- version = 'v1.*',
    -- version = '*',
    build = 'cargo build --release',
    lazy = false, -- lazy loading handled internally
    dependencies = {
        { 'L3MON4D3/LuaSnip', version = 'v2.*' },

        --2: NOTE:
        --2  I use vim.print to get the  curl/wget url to download the binary manually, and i should use chmod +x 
        --2     wget https://supermaven-public.s3.amazonaws.com/sm-agent/v2/8/linux-musl/x86_64/sm-agent $HOME/.supermaven/binary/v20/linux-x86_64
        {
            "supermaven-inc/supermaven-nvim",
            dependencies ={
                "huijiro/blink-cmp-supermaven",
                "hrsh7th/nvim-cmp", 
            },
            opts = {
				disable_inline_completion = true, -- disables inline completion for use with cmp
				disable_keymaps = false, -- disables built in keymaps for more manual control with blink.cmp
                keymaps = {
                    accept_suggestion = nil,
                    clear_suggestion = nil,
                    accept_word = "<C-f>",
                }
            },
        },
        --1 NOTE:
        --1    this plugin, doesnt work as we expected. it's cruial for me to
        --1    use `menu.auto_show = false`, so ghost_text from blink.cmp and
        --1    codeium doesnt collaborate together to shown normally by respecting
        --1    scores, the accept on blink.cmp should be accept the virtual_text
        --1    from the shown one, and select_word doesnt work too.
        --1{
        --1    'Exafunction/codeium.nvim',
        --1    dependencies = {
        --1        'hrsh7th/nvim-cmp', 
        --1        { 'saghen/blink.compat', opts = { enable_events = true } }, 
        --1    },
        --1    build = 'Codeium Auth',
        --1    config = function()

        --1        local virtual_text = require("codeium.virtual_text")
        --1        -- Get codeium's augroup
        --1        local augroup = vim.api.nvim_create_augroup("codeium_virtual_text", { clear = false })
        --1        -- Hook into User.InsertLeaveCtrlC to clear virtual text.
        --1        vim.api.nvim_create_autocmd("User", {
        --1            group = augroup,
        --1            pattern = "InsertLeaveCtrlC",
        --1            callback = function()
        --1                virtual_text.clear()
        --1            end,
        --1        })

        --1        vim.api.nvim_set_keymap( "i", "<C-c>", [[<Esc>:doautocmd User InsertLeaveCtrlC<CR>]], { noremap = true, silent = true } )
        --1        -- vim.api.nvim_set_keymap('i', '<Esc>', '<C-c>', { noremap = true, silent = true })
        --1        vim.api.nvim_set_keymap('i', '<Esc>', [[<Esc>:doautocmd User InsertLeaveCtrlC<CR>]], { noremap = true, silent = true })

        --1        require('codeium.util').get_newline = function () return "\n" end

        --1        require('codeium').setup({
        --1            -- Optionally disable cmp source if using virtual text only
        --1            enable_cmp_source = false,
        --1            virtual_text = {
        --1                enabled = true,

        --1                -- Set to true if you never want completions to be shown automatically.
        --1                manual = false,
        --1                -- A mapping of filetype to true or false, to enable virtual text.
        --1                filetypes = {},
        --1                -- Whether to enable virtual text of not for filetypes not specifically listed above.
        --1                default_filetype_enabled = true,
        --1                -- How long to wait (in ms) before requesting completions after typing stops.
        --1                idle_delay = 75,
        --1                -- Priority of the virtual text. This usually ensures that the completions appear on top of
        --1                -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
        --1                -- desired.
        --1                virtual_text_priority = 65535,
        --1                -- Set to false to disable all key bindings for managing completions.
        --1                map_keys = true,
        --1                -- The key to press when hitting the accept keybinding but no completion is showing.
        --1                -- Defaults to \t normally or <c-n> when a popup is showing.
        --1                accept_fallback = nil,
        --1                -- Key bindings for managing completions in virtual text mode.
        --1                key_bindings = {
        --1                    accept = false,
        --1                    accept_word = 'C-g',
        --1                    accept_line = '<C-f>',
        --1                    next = '<C-]>',
        --1                    prev = '<C-[>',
        --1                },
        --1            },
        --1        })
        --1    end,
        --1},
        'rafamadriz/friendly-snippets',
        'Kaiser-Yang/blink-cmp-dictionary',
    },
    opts = {
        snippets = { preset = 'luasnip' },
        cmdline = {
            -- keymap = {},
            enabled = true,
            completion = {
                menu = { auto_show = true },
                ghost_text = { enabled = true },
            },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        keymap = {
            preset = 'default',
            ['<C-y>'] = { 'hide' },
            ['<C-e>'] = { 'select_and_accept' },
            -- ['<C-j>'] = { 'snippet_forward' },
            -- ['<C-k>'] = { 'snippet_backward' },
			['<C-n>'] = { 'select_next', 'fallback' },
			['<C-p>'] = { 'select_prev', 'fallback' },
            ['<C-l>'] = { 'snippet_forward' },
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
            ghost_text = {
                show_with_menu = false,
                enabled = true
            },
            documentation = {
                auto_show = false,
                window = { border = 'rounded' },
            },
            list = {
                selection = { preselect = true, auto_insert = true },
            },
        }, -- end completion
        sources = {
            -- 'copilot', 'omni',
            -- default = { 'lsp', 'path', 'snippets', 'buffer', 'dictionary', 'cmdline', 'codeium' },
            default = { 'lsp','supermaven', 'path', 'snippets', 'buffer', 'dictionary', 'cmdline' },
            providers = {
                lsp = {
                    name = 'LSP',
                    module = 'blink.cmp.sources.lsp',
                    opts = {}, -- Passed to the source directly, varies by source
                    --  NOTE: All of these options may be functions to get dynamic behavior
                    --  NOTE: See the type definitions for more information
                    enabled = true, -- Whether or not to enable the provider
                    async = false, -- Whether we should wait for the provider to return before showing the completions
                    timeout_ms = 60, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
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
                -- codeium = {
                --     name = 'codeium',
                --     module = 'blink.compat.source',
                --     score_offset = 100,
                --     async = true,
                -- },
				supermaven = {
					name = "supermaven",
					module = "blink-cmp-supermaven",
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
}
