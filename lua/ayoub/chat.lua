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

M.nvim_get_selected_text = function()
  local from_pos, to_pos = vim.fn.getpos "'<", vim.fn.getpos "'>"
  local from, to = { line = from_pos[2], col = from_pos[3] }, { line = to_pos[2], col = to_pos[3] }
  -- Tweak for linewise Visual selection
  if vim.fn.visualmode() == 'V' then
    from.col, to.col = 1, vim.fn.col { to.line, '$' } - 1
  end

  local lines = vim.api.nvim_buf_get_text(0, from.line - 1, from.col - 1, to.line - 1, to.col, {})
  return lines or {}
end

M.main = function(engine)
  if not engine then
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { '# ---no-engine----' })
    return
  end

  local all_lines = {}
  if vim.fn.visualmode() ~= 'V' or vim.fn.visualmode() ~= 'V' then
    all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  else
    all_lines = M.nvim_get_selected_text()
  end

  M.ask(engine, all_lines)
end

return M
