P = function(v)
  print(vim.inspect(vim))
  return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

FormatFunction = function()
  vim.lsp.buf.format {
    async = true,
    range = {
      ['start'] = vim.api.nvim_buf_get_mark(0, '<'),
      ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
    },
  }
end
