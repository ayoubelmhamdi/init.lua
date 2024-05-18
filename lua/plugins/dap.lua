return {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
        { 'leoluz/nvim-dap-go' },
        {
            'LiadOz/nvim-dap-repl-highlights',
        },
        {
            'Weissle/persistent-breakpoints.nvim',
            event = 'BufReadPost',
            keys = {
                { '<leader>db', "<cmd>lua require'persistent-breakpoints.api'.toggle_breakpoint()<cr>" },
                { '<Leader>dbc', "<cmd>lua require'persistent-breakpoints.api'.set_conditional_breakpoint()<cr>" },
            },
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            config = function()
                require('nvim-dap-virtual-text').setup({
                    all_frames = false,
                    virt_lines = false,
                    virt_text_win_col = 80,
                })
            end,
        },
        { 'LiadOz/nvim-dap-repl-highlights' },
        {
            'rcarriga/nvim-dap-ui',
            keys = {
                { '<A-e>', '<cmd>lua require("dapui").eval()<CR>', mode = { 'n', 'v' }, { noremap = true, silent = true } },
            },
            dependencies = 'nvim-neotest/nvim-nio',
        },
        {
            'mfussenegger/nvim-dap-python',
            keys = {
                { '<leader>dPt', function() require('dap-python').test_method() end },
                { '<leader>dPc', function() require('dap-python').test_class() end },
            },
        },
    },
    keys = {
        { '<space>dc', "<cmd>lua require'dap'.continue()<cr>" },
        { '<space>dn', "<cmd>lua require'dap'.step_over()<cr>" },
        { '<space>ds', "<cmd>lua require'dap'.step_into()<cr>" },
        { '<space>do', "<cmd>lua require'dap'.step_out()<cr>" },
        { '<space>dr', "<cmd>lua require'dap'.restart()<cr>" },
        { '<space>dro', "<cmd>lua require'dap'.repl_open()<cr>" },
        { '<space>du', "<cmd>lua require'dapui'.toggle()<cr>" },
        { '<space>dhh', "<cmd>lua require('dap.ui.variables').hover()<CR>" },
        { '<space>dhv', "<cmd>lua require('dap.ui.variables').visual_hover()<CR>" },

        { '<Leader>duf', "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>" },
    },
    config = function ()
        require('custom.dap')
    end
}
