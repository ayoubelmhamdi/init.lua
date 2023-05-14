local CHAT = {}

function CHAT.ask(engine)
  if not engine then
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { '---no-engine----' })
    return
  end

  local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  all_lines = table.concat(all_lines, '\n')

  local command = { engine, '-m', all_lines }
  local append_data = function(_, data)
    if data then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, data)
    end
  end

  vim.api.nvim_buf_set_lines(0, -1, -1, false, { '---' .. engine .. '----' })
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data,
  })
end

return CHAT
