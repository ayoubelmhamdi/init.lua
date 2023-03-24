local M = {}
function M.MyCodeActions()
  vim.lsp.buf.code_action {
    filter = function(action)
      return action.kind ~= 'source.organizeImports'
    end,
  }
end

function M.ListCodeActions()
  print 'ls...'
  local protocol = require 'vim.lsp.protocol'
  for _, value in pairs(protocol.CodeActionKind) do
    print(value)
  end
end

return M
