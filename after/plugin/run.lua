local python = true
local pattern = 'test.sh'
local command = { './test.sh' }

if python then
  pattern = 'test2.py'
  command = { './test2.py' }
end

-- It's our main starting function. For now we will only creating navigation window here.
local win
local start_win
local buf

Create_win = function()
  -- We save handle to window from which we open the navigation
  start_win = vim.api.nvim_get_current_win()

  vim.api.nvim_command 'botright new' -- We open a new vertical window at the far right
  win = vim.api.nvim_get_current_win() -- We save our navigation window handle...
  buf = vim.api.nvim_get_current_buf() -- ...and it's buffer handle.

  -- We should name our buffer. All buffers in vim must have unique names.
  -- The easiest solution will be adding buffer handle to it
  -- because it is already unique and it's just a number.
  vim.api.nvim_buf_set_name(buf, 'Output' .. buf)

  -- Now we set some options for our buffer.
  -- nofile prevent mark buffer as modified so we never get warnings about not saved changes.
  -- Also some plugins treat nofile buffers different.
  -- For example coc.nvim don't triggers aoutcompletation for these.
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  -- We do not need swapfile for this buffer.
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  -- And we would rather prefer that this buffer will be destroyed when hide.
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  -- It's not necessary but it is good practice to set custom filetype.
  -- This allows users to create their own autocommand or colorschemes on filetype.
  -- and prevent collisions with other plugins.
  -- vim.api.nvim_buf_set_option(buf, 'filetype', 'nvim-oldfile')

  -- For better UX we will turn off line wrap and turn on current line highlight.
  vim.api.nvim_win_set_option(win, 'wrap', false)
  vim.api.nvim_win_set_option(win, 'cursorline', true)

  if win and vim.api.nvim_win_is_valid(start_win) then
    vim.api.nvim_set_current_win(start_win)
  else
    print 'no win'
  end
end

local attach_to_buffer = function()
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('TJ', { clear = true }),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
          -- else
          --     print 'test1'
        end
      end
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, { '' })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('Ay', { clear = true }),
  pattern = pattern,
  callback = function()
    Create_win()
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('TJ', { clear = true }),
  pattern = pattern,
  callback = function()
    attach_to_buffer()
  end,
})
