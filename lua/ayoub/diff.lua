local M = {}
local uv = vim.uv or vim.loop
local key = vim.keymap.set
local opt = { noremap = true, silent = true }

M.parent_win = nil
M.parent_buf = nil
M.child_win = nil
M.child_buf = nil

M.job_id = nil
M.current_file_path = nil

local backup_keys = { '<C-J>' }
M.original_keymaps = {}

M.kinds = {
    full = 1,
    range = 2,
    diff = 3,
}


M.create_win = function()
    if M.child_win or M.child_win then
        return nil -- used for toggle feature
    end
    M.backup_keymaps()

    M.parent_win = vim.api.nvim_get_current_win()
    M.parent_buf = vim.api.nvim_get_current_buf()
    local buftype = vim.bo.filetype

    vim.api.nvim_win_set_option(M.parent_win, 'wrap', true)
    vim.cmd.diffthis()

    vim.api.nvim_command('botright vnew')
    M.child_win = vim.api.nvim_get_current_win()
    M.child_buf = vim.api.nvim_get_current_buf()
    -- vim.api.nvim_buf_set_name(M.child_buf, 'Diff: ' .. M.child_buf)
    vim.api.nvim_buf_set_option(M.child_buf, 'buftype', 'nofile') -- modifiable...
    vim.bo[M.child_buf].filetype = buftype -- lang
    vim.api.nvim_buf_set_option(M.child_buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(M.child_buf, 'swapfile', false)
    vim.api.nvim_win_set_option(M.child_win, 'wrap', true)
    vim.cmd.diffthis()

    if not M.child_win then
        print('no M.child_win')
    elseif vim.api.nvim_win_is_valid(M.parent_win) then
        vim.api.nvim_set_current_win(M.parent_win)
    else
        print('no M.win and M.child_buf')
    end

    return true
end

M.close_child_win = function()
    if M.child_win and vim.api.nvim_win_is_valid(M.parent_win) then
        vim.api.nvim_win_close(M.child_win, 'force')
        vim.api.nvim_set_current_win(M.parent_win)
        vim.cmd('diffoff')
        -- TODO: 
        M.recover_keymaps()

        M.child_win = nil
        M.child_buf = nil
        M.job_id = nil
    else
        print('no M.win or M.child_win')
    end
end

M.toggle = function(kind, command)
    if not M.create_win() then
        M.close_child_win()
        return
    end

    if not M.job_id then
        -- full = fullfile_to_child_buf: the tmpfile is all output that's we need
        if kind == M.kinds['full'] then
            M.full(command)

        -- range = range_to_child_buf: the tmpfile is just a range of output that's we need
        elseif kind == M.kinds['range'] then
            M.range(command)

        --- diff = diff_to_child_buf: the tmpfile is just a diff file that we need to generate the full output.
        elseif kind == M.kinds['diff'] then
            diffs = M.generate_diff(command)
            if not M.isempty(diffs) then M.diff(diffs) end
        end
    else
        print('assert: the job_id: ' .. M.job_id .. 'should not be exist.')
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

M.diff = function(diff)
    -- copy buffer of current file to dir.XXXX/file.txt
    local cur_lines = vim.api.nvim_buf_get_lines(M.parent_buf, 0, -1, true)
    local bufname = vim.api.nvim_buf_get_name(M.parent_buf) -- /home/mhamdi/file.txt
    local basename = M.basename(bufname) -- file.txt

    local dir = M.mktempDir()
    local cur_tmpfile = dir .. '/' .. basename
    vim.fn.writefile(cur_lines, cur_tmpfile)

    -- save diff table to the dir.XXXX/diff.diff
    local tmp_tmpfile = dir .. '/' .. 'diff.diff'
    if type(diff) == 'string' then -- path
        local tmp_lines = vim.fn.readfile(diff)
        vim.fn.writefile(tmp_lines, tmp_tmpfile)
    elseif type(diff) == 'table' then
        vim.fn.writefile(diff, tmp_tmpfile)
    end

    -- we have /tmp/diff.XXXX/file.txt and /tmp/diff.XXXX/diff.diff.
    -- we create the new file.txt based on diff.diff using patch command.
    local child_lines
    patch = { 'patch', cur_tmpfile, tmp_tmpfile }
    M.job_id = vim.fn.jobstart(patch, {
        -- cwd = '/tmp/',
        stdout_buffered = true,
        on_stdout = function(_, _lines)
            -- vim.print(_lines) -- @loggin
            child_lines = vim.fn.readfile(cur_tmpfile) -- read after patch it.
        end,
        on_stderr = M.stderr,
    })
    vim.fn.jobwait({ M.job_id })
    if not M.job_id then print('Failed to start job for command:') end

    M.rmtempDir(dir)

    vim.api.nvim_buf_set_lines(M.child_buf, 0, -1, false, child_lines)
end

M.generate_diff = function(command)
    local bufname = vim.api.nvim_buf_get_name(M.parent_buf) -- /home/mhamdi/file.txt
    local basename = M.basename(bufname) -- file.txt
    table.insert(command, basename)
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

M.basename = function(path)
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
    for _, map in ipairs(vim.api.nvim_get_keymap('n')) do
        for _, key in ipairs(backup_keys) do
            if map.lhs == key then
                M.original_keymaps[map.lhs] = map.rhs
                break
            end
        end
    end

    key('n', '<C-J>', ':w<cr>:diffget<cr>]c', opt)
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
