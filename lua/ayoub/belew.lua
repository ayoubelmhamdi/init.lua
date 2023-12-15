local M = {}

M.start_win = -1
M.start_buf = -1
M.term_win = -1
M.term_buf = -1

local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)

M.Create_win = function()
    -- We save handle to window from which we open the navigation
    M.start_win = vim.api.nvim_get_current_win()
    M.start_buf = vim.api.nvim_get_current_buf()

    -- vim.api.nvim_command 'botright new' -- We open a new vertical/horisontal window at the far right
    vim.cmd('below split')
    vim.cmd('terminal')
    M.term_win = vim.api.nvim_get_current_win() -- We save our navigation window handle...
    M.term_buf = vim.api.nvim_get_current_buf() -- ...and it's buffer handle.
    -- We should name our buffer. All buffers in vim must have unique names.
    -- The easiest solution will be adding buffer handle to it
    -- because it is already unique and it's just a number.
    vim.api.nvim_buf_set_name(M.term_buf, 'Output' .. M.term_buf)

    -- Now we set some options for our buffer.
    -- nofile prevent mark buffer as modified so we never get warnings about not saved changes.
    -- Also some plugins treat nofile buffers different.
    -- For example coc.nvim don't triggers aoutcompletation for these.
    -- vim.api.nvim_buf_set_option(M.buf, 'buftype', 'nofile')
    -- We do not need swapfile for this buffer.
    vim.api.nvim_buf_set_option(M.term_buf, 'swapfile', false)
    -- And we would rather prefer that this buffer will be destroyed when hide.
    vim.api.nvim_buf_set_option(M.term_buf, 'bufhidden', 'wipe')
    -- It's not necessary but it is good practice to set custom filetype.
    -- This allows users to create their own autocommand or colorschemes on filetype.
    -- and prevent collisions with other plugins.
    -- vim.api.nvim_buf_set_option(M.buf, 'filetype', 'nvim-oldfile')

    -- For better UX we will turn off line wrap and turn on current line highlight.
    vim.api.nvim_win_set_option(M.term_win, 'wrap', false)
    vim.api.nvim_win_set_option(M.term_win, 'cursorline', true)
end

M.main = function()
    local line = vim.api.nvim_get_current_line()

    if M.term_win == -1 or not vim.api.nvim_win_is_valid(M.term_win) or not vim.api.nvim_win_is_valid(M.start_win) then M.Create_win() end

    if M.term_win ~= M.start_win then
        vim.api.nvim_set_current_win(M.term_win)
        vim.fn.feedkeys('a')
        vim.fn.feedkeys('clear' .. enter)
        vim.fn.feedkeys(line .. enter)
        print('[term_win: ' .. M.term_win .. ', start_win: ' .. M.start_win .. ', start_buf: ' .. M.start_buf .. ', term_buf: ' .. M.term_buf .. '] line: "' .. line .. '"')
    else
        print('no win')
    end
end

M.get_buf = function() return M.term_buf end

M.get_win = function() return M.term_win end

M.get_start_win = function() return M.start_win end

return M
