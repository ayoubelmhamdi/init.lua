local M = {}

M.defualt_opts = { noremap = true, silent = true }

M.n = function(lhs, rhs, opts)
  opts = opts or M.defualt_opts
  vim.keymap.set("n", lhs, rhs, opts)
end

M.v = function(lhs, rhs, opts)
  opts = opts or M.defualt_opts
  vim.keymap.set("v", lhs, rhs, opts)
end

M.i = function(lhs, rhs, opts)
  opts = opts or M.defualt_opts
  vim.keymap.set("i", lhs, rhs, opts)
end

M.x = function(lhs, rhs, opts)
  opts = opts or M.defualt_opts
  vim.keymap.set("x", lhs, rhs, opts)
end

M.o = function(lhs, rhs, opts)
  opts = opts or M.defualt_opts
  vim.keymap.set("o", lhs, rhs, opts)
end

M.t = function(lhs, rhs, opts)
  opts = opts or M.defualt_opts
  vim.keymap.set("t", lhs, rhs, opts)
end

return M
