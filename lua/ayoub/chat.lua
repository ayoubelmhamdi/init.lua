local M = {}

function M.ask(engine, all_lines)
  local text = table.concat(all_lines, '\n')

  local command = { engine, '-m', text }
  local append_data = function(_, data)
    if data then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, data)
    end
  end

  vim.api.nvim_buf_set_lines(0, -1, -1, false, { '# ---' .. engine .. '----' })
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data,
  })
end

M.main = function(engine, mode)
  if not engine then
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { '# ---no-engine----' })
    return
  end

  NORMAL_MODE = mode

  local all_lines = {}
  if NORMAL_MODE then
    all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  else
    all_lines = M.nvim_get_selected_text()
  end
  M.ask(engine, all_lines)
end

M.nvim_get_selected_text = function()
  local bufnr = vim.api.nvim_get_current_buf()
  -- get start/end of visual selection
  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(bufnr, '<'))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(bufnr, '>'))
  local text = vim.api.nvim_buf_get_text(bufnr, start_row - 1, start_col, end_row - 1, end_col + 1, {})
  return text or {}
end

return M
