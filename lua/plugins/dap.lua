return {
    -- Dap
    'mfussenegger/nvim-dap',
    -- optional = true,
    event = 'VeryLazy',
    dependencies = {
        { 'leoluz/nvim-dap-go' },
        {
            'LiadOz/nvim-dap-repl-highlights',
            config = function() require('nvim-dap-repl-highlights').setup() end,
        },
        {
            'Weissle/persistent-breakpoints.nvim',
            config = function() require('persistent-breakpoints').setup({ load_breakpoints_event = { 'BufReadPost' } }) end,
            event = 'BufReadPost',
            keys = {
                { '<leader>db',  ":lua require'persistent-breakpoints.api'.toggle_breakpoint()<cr>",         desc = 'debug breakpoint' },
                { '<Leader>dbc', ":lua require'persistent-breakpoints.api'.set_conditional_breakpoint()<cr>" },
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
        {
            'LiadOz/nvim-dap-repl-highlights',
            config = function() require('nvim-dap-repl-highlights').setup() end,
        },
        {
            'rcarriga/nvim-dap-ui',
            keys = {
                { '<A-e>', '<cmd>lua require("dapui").eval()<CR>', mode = { 'n', 'v' }, { noremap = true, silent = true } },
            },
            config = function()
                vim.fn.sign_define('DapBreakpoint', { text = '🦦', texthl = '', linehl = '', numhl = '' })

                -- dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
                -- dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
                require('dapui').setup({
                    icons = { expanded = '▾', collapsed = '▸' },
                    layouts = {
                        { elements = { 'scopes', 'breakpoints', 'repl' }, size = 40, position = 'left' },
                        { elements = { 'watches', 'console' },            size = 10, position = 'bottom' },
                    },
                })
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
        { '<leader><space>', ":lua require'dap'.step_over()<cr>zz",                                                    desc = 'debug next' },
        { '<leader>dc',      ":lua require'dap'.continue()<cr>",                                                       desc = 'debug' },
        { '<leader>dn',      ":lua require'dap'.step_over()<cr>",                                                      desc = 'debug next' },
        { '<leader>ds',      ":lua require'dap'.step_into()<cr>",                                                      desc = 'debug into' },
        { '<leader>do',      ":lua require'dap'.step_out()<cr>",                                                       desc = 'debug out' },
        { '<leader>dr',      ":lua require'dap'.restart()<cr>",                                                        desc = 'debug repl' },
        { '<leader>dro',     ":lua require'dap'.repl_open()<cr>",                                                      desc = 'debug repl' },
        { '<leader>du',      ":lua require'dapui'.toggle()<cr>",                                                       desc = 'debug ui' },
        { '<Leader>dhh',     ":lua require('dap.ui.variables').hover()<CR>" },
        { '<Leader>dhv',     ":lua require('dap.ui.variables').visual_hover()<CR>" }, --v

        { '<Leader>duf',     ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>" },
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        local api = vim.api
        dap.defaults.fallback.exception_breakpoints = { 'raised' }
        dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end

        -- require('dap.ext.vscode').load_launchjs(nil, { cppdbg = {'c', 'cpp'} })
        require('dap.ext.vscode').load_launchjs()
        -- dap.configurations.python = {
        --     {
        --         type = 'python',
        --         request = 'launch',
        --         name = 'Launch file',
        --         program = '${file}',
        --         cwd = vim.fn.getcwd(),
        --         justMyCode = false,
        --         console = 'integratedTerminal',
        --         autoReload = { enbale = true },
        --     },
        -- }

        local keymap_restore = {} --{{{
        dap.listeners.after['event_initialized']['me'] = function()
            for _, buf in pairs(api.nvim_list_bufs()) do
                local keymaps = api.nvim_buf_get_keymap(buf, 'n')
                for _, keymap in pairs(keymaps) do
                    if keymap.lhs == 'K' then
                        table.insert(keymap_restore, keymap)
                        api.nvim_buf_del_keymap(buf, 'n', 'K')
                    end
                end
            end
            api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dapui").eval()<CR>', { silent = true })
        end

        dap.listeners.after['event_terminated']['me'] = function()
            for _, keymap in pairs(keymap_restore) do
                api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs,
                    { silent = keymap.silent == 1 })
            end
            keymap_restore = {}
        end
    end,
    -- }}}
}
