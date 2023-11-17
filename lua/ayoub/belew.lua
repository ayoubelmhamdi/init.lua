local M = {}

M.start_win = 0
M.win = 0
M.buf = 0

M.Create_win = function()
  -- We save handle to window from which we open the navigation
  M.start_win = vim.api.nvim_get_current_win()

  vim.api.nvim_command 'botright new' -- We open a new vertical/horisontal window at the far right
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
    print 'no win'
  end
end

M.main = function()
  if M.win == 0 then
    M.Create_win()
  end

  -- local command = { 'bash', '-c', 'echo -e "1+2" "yees\n"    "aa\nsss"' .. ' 2>&1' }
  -- local command = { 'bash', '-c', '\'echo -e "1+2" "yees\n"    "aa\nsss"' .. " 2>&1'" }
  local line = vim.api.nvim_get_current_line()
  local command = { 'bash', '-c', line .. ' 2>&1' }

  local append_data = function(_, data)
    if data then
      vim.api.nvim_win_set_height(M.win, #data + 4)
      vim.api.nvim_buf_set_lines(M.buf, -1, -1, false, data)
      if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_set_current_win(M.win)
      else
        print 'no win'
      end
    end
  end

  vim.cmd [[redraw]]
  -- vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, {})

  vim.fn.jobstart(command, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = append_data,
    on_error = append_data,
  })
end

return M
