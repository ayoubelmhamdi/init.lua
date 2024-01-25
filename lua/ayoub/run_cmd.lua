local M = {}

M.win = nil
M.start_win = nil
M.buf = nil
M.job_id = nil
M.command = { './box' }

M.create_win = function()
    -- We save handle to window from which we open the navigation
    M.start_win = vim.api.nvim_get_current_win()

    vim.api.nvim_command('botright new') -- We open a new vertical window at the far right
    M.win = vim.api.nvim_get_current_win() -- We save our navigation window handle...
    M.buf = vim.api.nvim_get_current_buf() -- ...and it's buffer handle.

    -- We should name our buffer. All buffers in vim must have unique names.
    -- The easiest solution will be adding buffer handle to it
    -- because it is already unique and it's just a number.
    vim.api.nvim_buf_set_name(M.buf, 'Output' .. M.buf)

    -- Now we set some options for our buffer.
    -- nofile prevent mark buffer as modified so we never get warnings about not saved changes.
    -- Also some plugins treat nofile buffers different.
    -- For example coc.nvim don't triggers aoutcompletation for these.
    vim.api.nvim_buf_set_option(M.buf, 'buftype', 'nofile')
    -- We do not need swapfile for this buffer.
    vim.api.nvim_buf_set_option(M.buf, 'swapfile', false)
    -- And we would rather prefer that this buffer will be destroyed when hide.
    vim.api.nvim_buf_set_option(M.buf, 'bufhidden', 'wipe')
    -- It's not necessary but it is good practice to set custom filetype.
    -- This allows users to create their own autocommand or colorschemes on filetype.
    -- and prevent collisions with other plugins.
    -- vim.api.nvim_buf_set_option(M.buf, 'filetype', 'nvim-oldfile')

    -- For better UX we will turn off line wrap and turn on current line highlight.
    vim.api.nvim_win_set_option(M.win, 'wrap', false)
    vim.api.nvim_win_set_option(M.win, 'cursorline', true)

    if M.win and vim.api.nvim_win_is_valid(M.start_win) then
        vim.api.nvim_set_current_win(M.start_win)
    else
        print('no M.win')
    end
end

M.append_data = function(_, data)
    if data then
        vim.api.nvim_buf_set_lines(M.buf, -1, -1, false, data)
    else
        vim.api.nvim_buf_set_lines(M.buf, -1, -1, false, { '---', '++++' })
    end
end

M.attach_to_buffer = function()
    vim.api.nvim_command('silent make')

    local qflist = vim.fn.getqflist()
    local error_count = 0
    for _, item in pairs(qflist) do
        if item.valid == 1 and (item.type == nil or item.type == '') then
            error_count = error_count + 1
            -- break -- check if not zero and stop
        end
    end

    if error_count == 0 then
        if M.start_win == nil then M.create_win() end
        vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, { '' })

        if M.job_id ~= nil then vim.fn.jobstop(M.job_id) end
        M.job_id = vim.fn.jobstart(M.command, {
            stdout_buffered = false,
            on_stdout = M.append_data,
            on_stderr = M.append_data,
        })
    end
end

return M
