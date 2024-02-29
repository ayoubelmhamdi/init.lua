local M = {}

M.win = nil
M.start_win = nil
M.buf = nil
M.job_id = nil
-- M.command = { './box' }

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

M.attach_to_buffer = function(command)
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
        M.job_id = vim.fn.jobstart(command, {
            stdout_buffered = false,
            on_stdout = M.append_data,
            on_stderr = M.append_data,
        })
    end
end

M.stderr = function(_, data) print('error in stderr') end
M.stdout = function(_, data)
    print('start2')
    vim.print(data)

    -- Initialize an empty table for quickfix entries
    local qf_entries = {}

    -- Parse each line of the output
    local file = '@@'
    local line2 = '##'
    local text2 = '??'
    for _, line in ipairs(data) do
        local file_path, line_number, text = line:match('(.-):(%d+):(.*)')
        if file_path and line_number then
            file = file_path
            line2 = line_number
            text2 = text
            print('filename: ' .. file .. ' line2: ' .. line2 .. ' text2: ' .. text2)
            table.insert(qf_entries, {
                filename = file_path,
                lnum = tonumber(line_number),
                text = text or 'No additional message',
            })
        end
    end

    --1-- Update the quickfix list with the parsed entries
    --1if #qf_entries > 0 then
    --1    vim.fn.setqflist(qf_entries)
    --1    -- Optionally, open the quickfix window
    --1    vim.api.nvim_command('copen')
    --1end
end

M.output_to_quickfix = function(command)
    -- Start the job
    local job_id = vim.fn.jobstart(command, {
        -- stdout_buffered = true,
        on_stdout = M.stdout,
        -- on_stderr = M.stderr,
        on_stderr = M.stdout,
    })

    -- Check if the job started successfully
    if not job_id then
        print('Failed to start job for command:')
    else
        print('job_id: ' .. job_id)
    end
end

return M
