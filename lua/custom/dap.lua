local REQ = require('ayoub.mini_functions').REQ

local repl = REQ('nvim-dap-repl-highlights')
local breakpoints = REQ('persistent-breakpoints')
local virtual_text = REQ('nvim-dap-virtual-text')
local dap = REQ('dap')
local dapui = REQ('dapui')
local dap_python = REQ('dap-python')
local dap_vscode = REQ('dap.ext.vscode')

if not (dap and repl and breakpoints and virtual_text and dapui and dap_python and dap_vscode) then return end

local api = vim.api
vim.fn.sign_define('DapBreakpoint', { text = '🦦', texthl = '', linehl = '', numhl = '' })

repl.setup()
dap_python.setup('python3')

breakpoints.setup({ load_breakpoints_event = { 'BufReadPost' } })
virtual_text.setup({
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = 80,
})

-- dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
-- dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
dapui.setup({
    icons = { expanded = '▾', collapsed = '▸' },
    layouts = {
        { elements = { 'scopes', 'breakpoints', 'repl' }, size = 40, position = 'left' },
        { elements = { 'watches', 'console' }, size = 10, position = 'bottom' },
    },
})

dap.defaults.fallback.exception_breakpoints = { 'raised' }
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end

dap_vscode.load_launchjs()

dap.adapters.lldb = {
    type = 'server',
    port = '${port}',
    executable = {
        -- CHANGE THIS to your path!
        command = '/usr/bin/lldb-vscode',
        args = { '--port', '${port}' },

        -- On windows you may have to uncomment this:
        -- detached = false,
    },
}

dap.configurations.c = {
    {
        name = 'Launch file',
        type = 'lldb',
        request = 'launch',
        program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
        args = { 'srt1.srt' },
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

-- Map K to hover while session is active.
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
        local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == 'K' then
                table.insert(keymap_restore, keymap)
                vim.api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end

    vim.keymap.set('n', 'K', require('dap.ui.widgets').hover, { silent = true })
    vim.opt.signcolumn = 'yes'
end

dap.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keymap_restore) do
        local rhs = keymap.callback ~= nil and keymap.callback or keymap.rhs
        vim.keymap.set(keymap.mode, keymap.lhs, rhs, { buffer = keymap.buffer, silent = keymap.silent == 1 })
    end
    keymap_restore = {}
    vim.opt.signcolumn = 'no'
end
