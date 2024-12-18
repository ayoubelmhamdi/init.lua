return {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = {
        -- { 'nvim-tree/nvim-web-devicons' },
        { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
        require('lspsaga').setup({
            symbol_in_winbar = {
                enable = false,
            },

            lightbulb = {
                enable = true,
                enable_in_insert = false,
                sign = true,
                sign_priority = 40,
                virtual_text = true,
            },
        })

        local keymap = vim.keymap.set

        -- saga.init_lsp_saga {
        --   border_style = 'rounded',
        -- }

        keymap({ 'n', 'v' }, '<space>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
        keymap('n', '<space>rn', '<cmd>Lspsaga rename<CR>', { silent = true })
        -- keymap('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', { silent = true })

        keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
        keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })
        keymap('n', '<space>o', '<cmd>LSoutlineToggle<CR>', { silent = true })
        keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
        -- keymap('n', '<A-d>', '<cmd>Lspsaga open_floaterm<CR>', { silent = true })
        -- keymap('n', '<A-d>', '<cmd>Lspsaga open_floaterm lazygit<CR>', { silent = true })
        -- keymap('t', '<A-d>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

        -- Show line diagnostics
        -- keymap('n', '<space>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })

        keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })

        -- Only jump to error
        keymap('n', '[e', function() require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true })
        keymap('n', ']e', function() require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true })
    end,
}
