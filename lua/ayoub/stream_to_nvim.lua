local M = {}

-- Function to append data to the buffer
local function random_string()
  local str = ""
  for i = 1, 6 do
    str = str .. string.char(math.random(97, 122)) -- Append a random lowercase letter (ASCII a-z)
  end
  return   "stream" .. str
end

local function append_data(bufnr, data)
    if data then
        -- Append data to the buffer
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
    end
end

-- Function to handle job events
local function on_event_factory(bufnr)
    return function(job_id, data, event)
        append_data(bufnr, data)
    end
end

-- Function to run the command and stream output to a buffer
M.run = function(command)
    local buf_name = random_string() 
    -- Create a new buffer and set it up
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(bufnr)
    vim.api.nvim_buf_set_name(bufnr, buf_name) -- is absolutly usefull to not deleted when it hidden using my autocmd that try to delete any named buffers
    vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile') -- usefull to can write to it
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)
    vim.api.nvim_buf_set_option(bufnr, 'filetype', 'lprolog')
    vim.bo[bufnr].buflisted = true

    local function on_event(job_id, data, event)
        if data then
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
    end

    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, {"Execute: " .. command, '---------------', ''})
    vim.cmd.normal('ggdd')
    -- Start the job with the command
    local job_id = vim.fn.jobstart(command, {
        stdout_buffered = false,
        stderr_buffered = false,
        on_stdout = on_event,
        on_stderr = on_event,
        on_exit = function(job_id, exit_code, event)
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, {'---------------','Job finished with exit code: ' .. exit_code})
        end,
    })

    -- Handle job start errors
    if job_id == 0 then
        vim.api.nvim_err_writeln('Failed to start job: ' .. command)
    elseif job_id < 0 then
        vim.api.nvim_err_writeln('Invalid job id for command: ' .. command)
    end
end

return M
