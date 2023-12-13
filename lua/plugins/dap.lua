return {
    -- Dap
    'mfussenegger/nvim-dap',
    -- optional = true,
    event = 'VeryLazy',
    dependencies = {
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
        { 'leoluz/nvim-dap-go' },
        {
            'LiadOz/nvim-dap-repl-highlights',
            config = function() require('nvim-dap-repl-highlights').setup() end,
        },
        {
            'rcarriga/nvim-dap-ui',
            keys = {
                -- { '<A-e>', { '<cmd>lua require("dapui").eval()<CR>', mode = 'v' }, { noremap = true, silent = true } },
            },
            config = function()
                vim.fn.sign_define('DapBreakpoint', { text = '🦦', texthl = '', linehl = '', numhl = '' })

                local dap, dapui = require('dap'), require('dapui')
                dapui.setup()
                dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
                dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
                dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
            end,
        },
        {
            'mfussenegger/nvim-dap-python',
            keys = {
                { '<leader>dPt', function() require('dap-python').test_method() end },
                { '<leader>dPc', function() require('dap-python').test_class() end },
            },
            config = function() require('dap-python').setup('python3') end,
        },
    },
    keys = {
        { '<leader>db', ":lua require'dap'.toggle_breakpoint()<cr>", desc = 'debug breakpoint' },
        { '<leader>dc', ":lua require'dap'.continue()<cr>",          desc = 'debug' },
        { '<leader>dn', ":lua require'dap'.step_over()<cr>",         desc = 'debug next' },
        { '<leader>ds', ":lua require'dap'.step_into()<cr>",         desc = 'debug into' },
        { '<leader>do', ":lua require'dap'.step_out()<cr>",          desc = 'debug out' },
        { '<leader>dr', ":lua require'dap'.repl_open()<cr>",         desc = 'debug repl' },
        { '<leader>du', ":lua require'dapui'.toggle()<cr>",          desc = 'debug ui' },
    },
    config = function()
        require('dap').configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = 'Launch file',
                program = '${file}',
            },
        }
    end,
}
