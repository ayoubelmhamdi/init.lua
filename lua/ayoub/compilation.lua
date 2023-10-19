local M = {}

function M.OpenQuickfix(text)
  if text then
    vim.cmd(text)
  end
  -- vim.cmd "redraw!|echo 'make finished'"
  -- vim.cmd"exe \":!echo aaa\" | redraw"
  -- local qflist = vim.fn.getqflist()
  -- if #qflist > 0 then
  --     vim.cmd('copen')
  -- end
end

return M
