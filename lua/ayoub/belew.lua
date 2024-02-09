local M = {}

M.start_win = -1
M.start_buf = -1
M.term_win = -1
M.term_buf = -1

local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)

M.Create_win = function()
    M.start_win = vim.api.nvim_get_current_win()
    M.start_buf = vim.api.nvim_get_current_buf()
    vim.cmd('below split')
    vim.cmd('terminal')
    M.term_win = vim.api.nvim_get_current_win() -- We save our navigation window handle...
    M.term_buf = vim.api.nvim_get_current_buf() -- ...and it's buffer handle.
    vim.api.nvim_buf_set_name(M.term_buf, 'Output' .. M.term_buf)
    vim.api.nvim_buf_set_option(M.term_buf, 'swapfile', false)
    vim.api.nvim_buf_set_option(M.term_buf, 'bufhidden', 'wipe')
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
