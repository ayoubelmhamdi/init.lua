local M = {}

function M.define_sign(name, icon)
  vim.fn.sign_define(name, { text = icon, texthl = 'SignColumn' })
end

vim.fn.sign_define('Arrow', { text = '', texthl = 'Special' })

function M.place_sign(line, id)
  local buffer = vim.api.nvim_get_current_buf()
  vim.fn.sign_place(id, '', 'Arrow', buffer, { lnum = line })
end

function M.unplace_sign(id)
  local buffer = vim.api.nvim_get_current_buf()
  vim.fn.sign_unplace('', { id = id, buffer = buffer })
end
return M
