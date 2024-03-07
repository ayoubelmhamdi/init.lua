local M = {}

M.parent_win = nil
-- M.parent_buf = nil
M.child_win = nil
M.child_buf = nil

M.job_id = nil

M.create_win = function(file)
    if M.child_win or M.child_win then
        return nil -- used for toggle feature
    end

    M.parent_win = vim.api.nvim_get_current_win()

    vim.api.nvim_win_set_option(M.parent_win, 'wrap', true)
    vim.cmd "diffthis"

    -- vim.api.nvim_command('botright vnew' .. file)
    vim.api.nvim_command('botright vnew')
    M.child_win = vim.api.nvim_get_current_win()
    M.child_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(M.child_buf, 'Diff' .. M.child_buf)
    vim.api.nvim_buf_set_option(M.child_buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(M.child_buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(M.child_buf, 'swapfile', false)
    vim.api.nvim_win_set_option(M.child_win, 'wrap', true)
    vim.cmd "diffthis"

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
        vim.api.nvim_win_close(M.child_win,'force')
        M.child_win = nil
        M.child_buf = nil
        M.job_id = nil
    end

    if vim.api.nvim_win_is_valid(M.parent_win) then
        vim.api.nvim_set_current_win(M.parent_win)
        vim.cmd "diffoff"
    else
        print('no M.win')
    end
end


M.toggle = function(command, mode)
    -- command = command or '{'ruff', 'check', '--diff'}'
    command = command or { 'echo', '-e', 'aaa\neee' }
    mode = mode or 'full_tmp_file'
    -- local tmpfile = M.generate_tmp_file(mode)

    -- if tmpfile and not M.create_win(tmpfile) then
    if not M.create_win(tmpfile) then
        M.close_child_win()
        return 
    end

    if not M.job_id then
        M.runjob(command)
    else
        print('assert: the job_id: ' .. M.job_id .. 'should not be exist.')
    end

end

M.runjob = function (command)
    M.job_id = vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = M.stdout,
        on_stderr = M.stderr,
    })

    if not M.job_id then
        print('Failed to start job for command:')
    else
        print('job_id: ' .. M.job_id)
    end
end

M.generate_tmp_file = function(mode)
    -- current_file to /tmp/current_file.
    -- create_tmp:
    --   - maybe we generate a full tmpfile.
    --   - maybe we generate just a range from tmpfile base on a range of current_file, so we need the rest of tmpfile.
    --   - maybe we generate a diff file, so we need to backup current_file to tmp_current_file and generate tmpfile.

    local tmpfile = nil
    if mode == 'full_tmp_file' then
        return '/tmp/f.txt'
    elseif mode == 'range_tmp_file' then
        return '/tmp/r.txt'
    elseif mode == 'diff_to_tmp_file' then
        return '/tmp/d.txt'
    end

    return tmpfile
end


M.stderr = function(_, data) 
    -- todo: should imrobe check if all lines is empty or not
    -- we can test the number of line is great then one, or if we have one line we should check if is empty.
    if data[1] ~= "" then
        print('error in stderr')
        print('-------')
        vim.print(data)
        print('^^^^^^^^^')
    end
end

M.stdout = function(_, data)
    -- print('start2')
    if data then
        vim.api.nvim_buf_set_lines(M.child_buf, 0, -1, false, data)
    end
end

return M

-- TODO:
--  - ./ruff check --diff
--      - create a new file that different from the original.
--      - use the `diffthis` in parrent windows, than use it in the child window, and put the content of new file to child_win.
