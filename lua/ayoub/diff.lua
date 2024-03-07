local M = {}
local uv = vim.uv or vim.loop

M.parent_win = nil
M.parent_buf = nil
M.child_win = nil
M.child_buf = nil

M.job_id = nil
M.current_file_path = nil
M.dir = nil

local modes = {
    tmpfile_is_full_output = 1,
    tmpfile_is_range_of_output = 2,
    tmpfile_is_diff = 3,
}

M.create_win = function()
    M.dir = M.mktempDir()
    if M.child_win or M.child_win then
        return nil -- used for toggle feature
    end

    M.parent_win = vim.api.nvim_get_current_win()
    M.parent_buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_win_set_option(M.parent_win, 'wrap', true)
    vim.cmd.diffthis()

    -- vim.api.nvim_command('botright vnew' .. file)
    vim.api.nvim_command('botright vnew')
    M.child_win = vim.api.nvim_get_current_win()
    M.child_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(M.child_buf, 'Diff: ' .. M.child_buf)
    vim.api.nvim_buf_set_option(M.child_buf, 'buftype', 'nofile')
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
    if M.child_win then
        vim.api.nvim_win_close(M.child_win, 'force')
        M.child_win = nil
        M.child_buf = nil
        M.job_id = nil
        M.dir = nil

    end

    if vim.api.nvim_win_is_valid(M.parent_win) then
        vim.api.nvim_set_current_win(M.parent_win)
        vim.cmd('diffoff')
    else
        print('no M.win')
    end
end

M.toggle = function(command, mode)
    -- command = command or '{'ruff', 'check', '--diff'}'
    command = command or { 'echo', '-e', 'aaa\neee' }
    -- mode = mode or modes['tmpfile_is_full_output']
    -- mode = mode or modes['tmpfile_is_range_of_output']
    mode = mode or modes['tmpfile_is_diff']

    if not M.create_win() then
        M.close_child_win()
        return
    end

    if not M.job_id then
        if mode == modes['tmpfile_is_full_output'] then ---------- the tmpfile is all output that's we need
            M.fullfile_to_child_buf(command)
        elseif mode == modes['tmpfile_is_range_of_output'] then -- the tmpfile is just a range of output that's we need
            print('tmpfile_is_range_of_output')
        elseif mode == modes['tmpfile_is_diff'] then ------------- the tmpfile is just a diff file that we need to generate the full output.
            print('tmpfile_is_diff')
            M.diff_to_child_buf("./diff.diff")
        end
    else
        print('assert: the job_id: ' .. M.job_id .. 'should not be exist.')
    end
end

-- current_file to /tmp/current_file.
-- create_tmp:
--   - maybe we generate a full tmpfile.
--   - maybe we generate just a range from tmpfile base on a range of current_file, so we need the rest of tmpfile.
--   - maybe we generate a diff file, so we need to backup current_file to tmp_current_file and generate tmpfile.

M.fullfile_to_child_buf = function(command)
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

M.range_to_child_buf = function(start_line, end_line, range)
    local first = vim.api.nvim_buf_get_lines(M.parent_buf, 0, start_line, true)
    local last = vim.api.nvim_buf_get_lines(M.parent_buf, end_line, -1, true)
    -- table.concat(vim.fn.readfile "CONTRIBUTING.md", "\n")
    -- texts = concatenate (first + range + last)
    -- vim.api.nvim_buf_set_lines(buf_tmp_current_file, 0, -1, true, texts)
end

M.diff_to_child_buf = function(diff)
    -- current file path to dir.XXXX/file.txt
    local cur_lines = vim.api.nvim_buf_get_lines(M.parent_buf, 0, -1, true)
    local bufname = vim.api.nvim_buf_get_name(M.parent_buf) -- /home/mhamdi/file.txt
    local basename = M.basename(bufname) -- file.txt

    local dir = M.mktempDir()
    local cur_tmpfile = dir .. '/' .. basename
    vim.fn.writefile(cur_lines, cur_tmpfile)

    -- diff content/path to dir.XXXX/diff.diff
    local tmp_tmpfile = dir .. '/' .. 'diff.diff'
    if type(diff) == 'string' then -- path
        local tmp_lines = vim.fn.readfile(diff)
        vim.fn.writefile(tmp_lines, tmp_tmpfile)
    elseif type(diff) == 'table' then
        vim.fn.writefile(diff, tmp_tmpfile)
    end

    -- we have /tmp/diff.XXXX/file.txt and /tmp/diff.XXXX/diff.diff
    local child_lines
    command = { 'patch', cur_tmpfile, tmp_tmpfile }
    M.job_id = vim.fn.jobstart(command, {
        cwd = '/tmp/',
        stdout_buffered = true,
        on_stdout = function(_, _lines) 
            -- vim.print(_lines) -- @loggin
            child_lines = vim.fn.readfile(cur_tmpfile) -- read after patch it.
        end,
        on_stderr = M.stderr,
    })
    vim.fn.jobwait({ M.job_id })
    if not M.job_id then print('Failed to start job for command:') end

    vim.api.nvim_buf_set_lines(M.child_buf, 0, -1, false, child_lines)
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

M.mktempDir = function()
    return uv.fs_mkdtemp('/tmp/diff_XXXXXXXXX')
end

M.stderr = function(_, data)
    -- todo: should imrobe check if all lines is empty or not
    -- we can test the number of line is great then one, or if we have one line we should check if is empty.
    if data[1] ~= '' then
        print('error in stderr')
        print('-------')
        vim.print(data)
        print('~~~~~~~')
    end
end

M.put_to_child_buf = function(_, data)
    if data then vim.api.nvim_buf_set_lines(M.child_buf, 0, -1, false, data) end
end

return M

-- TODO:
--  - ./ruff check --diff
--      - create a new file that different from the original.
--      - use the `diffthis` in parrent windows, than use it in the child window, and put the content of new file to child_win.

-- don't use /tmp, try to use TMPDIR it's work in android/termux (universale)
