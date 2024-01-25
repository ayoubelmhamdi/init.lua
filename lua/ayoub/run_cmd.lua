local M = {}

M.win = nil
M.start_win = nil
M.buf = nil
M.job_id = nil
M.command = { './box' }

M.create_win = function()
    M.start_win = vim.api.nvim_get_current_win()

    vim.api.nvim_command('botright new')
    M.win = vim.api.nvim_get_current_win()
    M.buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(M.buf, 'Output' .. M.buf)
    vim.api.nvim_win_set_height(M.win, 10) -- 10 lines
    vim.api.nvim_win_set_width(M.win, 80) -- columns
    vim.api.nvim_buf_set_option(M.buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(M.buf, 'swapfile', false)
    vim.api.nvim_buf_set_option(M.buf, 'bufhidden', 'wipe')
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
            error_count = error_count + 1 -- break -- check if not zero and stop
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
