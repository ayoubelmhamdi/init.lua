local M = {}
local uv = vim.uv or vim.loop
local key = vim.keymap.set
local opt = { noremap = true, silent = true }

-- stat

M.parent_win = nil
M.parent_buf = nil

M.child_win = nil
M.child_buf = nil

M.job_id = nil
M.basename = nil
M.buftype = nil
M.original_keymaps = {}
M.cmds = {}


-- const
local backup_keys = { '<C-J>' }

local cmds = {
    python = {
        format = {
            target = 'diff',
            command = { 'ruff', 'format', '--diff' },
        },
        check = {
            target = 'diff',
            command = { 'ruff', 'check', '--diff' },
        },
        cmd = {
            target = 'range',
            command = { 'echo', '-e', 'hello\\nworld' },
        },
    },

    lua = {
        format = {
            target = 'diff',
            command = { 'stylua', '-s', '--check', '--output-format', 'Unified'},
        },
        -- check = {
        --     target = 'diff',
        --     command = { 'ruff', 'check', '--diff' },
        -- },
        -- cmd = {
        --     target = 'range',
        --     command = { 'echo', '-e', 'hello\\nworld' },
        -- },
    },

}



M.create_win = function()
    if M.child_win or M.child_win then return nil end

    -- init parent
    M.parent_win = vim.api.nvim_get_current_win()
    M.parent_buf = vim.api.nvim_get_current_buf()
    M.basename   = M.get_basename(vim.api.nvim_buf_get_name(M.parent_buf)) -- file.txt
    M.buftype    = vim.bo.filetype

    M.original_keymaps = M.backup_keymaps()

    -- Todo: store wraping option
    vim.api.nvim_win_set_option(M.parent_win, 'wrap', true)
    vim.cmd.diffthis()

    -- init parent
    vim.api.nvim_command('botright vnew')
    M.child_win = vim.api.nvim_get_current_win()
    M.child_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(M.child_buf, 'buftype', 'nofile') -- modifiable...
    vim.bo[M.child_buf].filetype = M.buftype -- lang
    vim.api.nvim_buf_set_option(M.child_buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(M.child_buf, 'swapfile', false)
    vim.api.nvim_win_set_option(M.child_win, 'wrap', true)
    vim.cmd.diffthis()


    local is_parent = vim.api.nvim_win_is_valid(M.parent_win)

    if     not M.child_win  then    print('no M.child_win')
    elseif is_parent        then    vim.api.nvim_set_current_win(M.parent_win)
    else                            print('no M.win and M.child_buf')
    end

    return true
end

M.close_child_win = function()
    if M.child_win and vim.api.nvim_win_is_valid(M.parent_win) then
        vim.api.nvim_win_close(M.child_win, 'force')
        vim.api.nvim_set_current_win(M.parent_win)
        vim.cmd.diffoff()
        M.recover_keymaps()


        M.parent_win = nil
        M.parent_buf = nil

        M.child_win = nil
        M.child_buf = nil

        M.job_id = nil
        M.basename = nil
        M.buftype = nil
        M.original_keymaps = {}
        M.cmds = {}
    else
        print('no M.win or M.child_win')
    end
end


M.toggle = function(kind)
    M.buftype = vim.bo.filetype
    local cmd = cmds[M.buftype][kind]
    if cmd then
        local target = cmd.target
        local command = cmd.command
        if target and command then
            if not M.create_win() then
                M.close_child_win()
                return
            end

            local func = M[target]
            func(command)
        else
            vim.notify('cmd or target is nil')
        end
    else
        vim.notify('Invalid kind: ' .. kind)
    end
end


M.full = function(command)
    M.job_id = vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = M.put_to_child_buf,
        on_stderr = M.stderr,
    })

    if not M.job_id then
        print('Failed to start job for command:')
    else
        print('job_id: ' .. M.job_id)
    end
end

M.range = function(command)
    local start = vim.api.nvim_buf_get_mark(0, '<')
    local end_ = vim.api.nvim_buf_get_mark(0, '>')

    local start_row = start[1]
    local start_col = start[2]
    local end_row = end_[1]
    local end_col = end_[2]

    -- if end_col == vim.v.maxcol then
    --     print('we are in Viual_Line kind: end_col == maxcol')
    -- end
    -- print('{start_row: ' .. start_row .. ', start_col: ' ..start_col .. ', end_row: ' .. end_row .. ', end_col: ' .. end_col .. '}')

    local midle = {}
    M.job_id = vim.fn.jobstart(command, {
        cwd = '/tmp/',
        stdout_buffered = true,
        on_stdout = function(_, _lines)
            table.remove(_lines) -- remove last line
            midle = _lines
        end,
        on_stderr = M.stderr,
    })
    vim.fn.jobwait({ M.job_id })

    local lines = {}
    local first = vim.api.nvim_buf_get_lines(M.parent_buf, 0, start_row, true)
    local last = vim.api.nvim_buf_get_lines(M.parent_buf, end_row, -1, true)

    for _, v in ipairs(first) do
        table.insert(lines, v)
    end
    for _, v in ipairs(midle) do
        table.insert(lines, v)
    end
    for _, v in ipairs(last) do
        table.insert(lines, v)
    end

    vim.api.nvim_buf_set_lines(M.child_buf, 0, -1, true, lines)
end

M.diff = function(cmd_diff, file_diff)
    local dir = M.mktempDir()

    -- copy buffer of current file to dir.XXXX/file.txt
    local cur_lines = vim.api.nvim_buf_get_lines(M.parent_buf, 0, -1, true)
    local cur_tmpfile = dir .. '/' .. M.basename
    vim.fn.writefile(cur_lines, cur_tmpfile)

    -- save diff table to the dir.XXXX/diff.diff
    local tmp_tmpfile = dir .. '/' .. 'diff.diff'
    if file_diff then
        local tmp_lines = vim.fn.readfile(file_diff)
        vim.fn.writefile(tmp_lines, tmp_tmpfile)
    else
        local diffs = M.generate_diff(cmd_diff)

        if M.isempty(diffs) then
            print('no diff created')
            M.close_child_win()
            return
        end

        vim.fn.writefile(diffs, tmp_tmpfile)
    end

    -- we have /tmp/diff.XXXX/file.txt and /tmp/diff.XXXX/diff.diff.
    -- we create the new file.txt based on diff.diff using patch command.
    local child_lines = {}
    local cmd_patch = { 'patch', cur_tmpfile, tmp_tmpfile }
    M.job_id = vim.fn.jobstart(cmd_patch, {
        stdout_buffered = true,
        on_stdout = function()
            child_lines = vim.fn.readfile(cur_tmpfile) -- callback: read from file (not stdout) after patch it.
        end,
        on_stderr = M.stderr,
    })
    vim.fn.jobwait({ M.job_id })
    if not M.job_id then print('Failed to start job for command:') end

    M.rmtempDir(dir)

    if M.isempty(child_lines) then vim.api.nvim_buf_set_lines(M.child_buf, 0, -1, false, child_lines) end
end

M.generate_diff = function(command)
    table.insert(command, M.basename)
    local diffs
    local bufname = vim.api.nvim_buf_get_name(M.parent_buf) -- /home/mhamdi/file.txt

    M.job_id = vim.fn.jobstart(command, {
        -- cwd = '/tmp/',
        stdout_buffered = true,
        on_stdout = function(_, _lines) diffs = _lines end,
        on_stderr = M.stderr,
    })
    vim.fn.jobwait({ M.job_id })
    if not M.job_id then print('Failed to start job for command:') end
    print(table.concat(diffs, '\n'))

    return diffs
end


M.get_basename = function(path)
    if path == '/' or path == '' then
        return
    elseif vim.endswith(path, '/') then
        return path:match('^.*/([^/]*)/$')
    else
        return path:match('^.*/([^/]*)$')
    end
end

-- M.join = function(...) return table.concat({ ... }, '/') end

M.mktempDir = function() return uv.fs_mkdtemp('/tmp/diff_XXXXXXXXX') end
M.rmtempDir = function(dir) vim.fn.system {'rm', '-rf', dir} end

M.isempty = function(t)
    if not t or not next(t) then return true end
    local k, v = next(t)
    return not next(t, k) and v == ''
end

M.backup_keymaps = function()
    keys = {}
    for _, map in ipairs(vim.api.nvim_get_keymap('n')) do -- add viual mode too.
        for _, key in ipairs(backup_keys) do
            if map.lhs == key then
                keys[map.lhs] = map.rhs
                break
            end
        end
    end

    key('n', '<C-J>', ':w<cr>:diffget<cr>]c', opt)
    return keys
end

M.recover_keymaps = function()
    for lhs, rhs in pairs(M.original_keymaps) do
        key('n', lhs, rhs, opt)
    end
    M.original_keymaps = {}
end

M.stderr = function(_, data)
    -- todo: should imrobe check if all lines is empty or not
    -- we can test the number of line is great then one, or if we have one line we should check if is empty.
    if data[1] ~= '' then
        print('-------')
        print('Stderr:')
        vim.print(data)
        print('~~~~~~~')
    end
end

M.put_to_child_buf = function(_, data)
    if data then vim.api.nvim_buf_set_lines(M.child_buf, 0, -1, false, data) end
end

return M
