-- mini function
M = {}
M.type_definition = function()
  vim.lsp.buf.type_definition()
end

M.workspace_symbol = function()
  vim.lsp.buf.workspace_symbol()
end

M.hover = function()
  vim.lsp.buf.hover()
end

M.open_float = function()
  vim.diagnostic.open_float()
end

M.goto_next = function()
  vim.diagnostic.goto_next()
end
M.goto_prev = function()
  vim.diagnostic.goto_prev()
end

M.code_action = function()
  vim.lsp.buf.code_action()
end

M.references = function()
  vim.lsp.buf.references()
end

M.rename = function()
  vim.lsp.buf.rename()
end

M.signature_help = function()
  vim.lsp.buf.signature_help()
end


M.toggleLsp = function()
  if vim.g.isLspStart then
    vim.cmd 'LspStop'
    vim.g.isLspStart = false
  else
    vim.cmd 'LspStart'
    vim.g.isLspStart = true
  end
  require('null-ls').toggle {}
end

return M
