local ts = require 'nvim-treesitter.parsers'
local bufnr_output = 14
local M = {}

function M.get_def_position()
  local params = vim.lsp.util.make_position_params()
  local results_lsp = vim.lsp.buf_request_sync(0, 'textDocument/definition', params)
  if not results_lsp[1].result or vim.tbl_isempty(results_lsp) then
    print 'No results from textDocument/definition'
    return
  end
  --print(vim.inspect(results_lsp[1].result[1].targetRange.start))
  local start = results_lsp[1].result[1].targetRange.start
  local col = start.character
  local line = start.line
  return line, col
end

function M.get_node_at_position(line, col)
  -- Get the current parser for the language
  --local parser = ts.get_parser().parse()
  local parser = vim.treesitter.get_parser()

  --local parser = vim.treesitter.get_parser():root()
  --node=vim.treesitter.get_node_at_pos(0, line, col)
  -- Parse the buffer
  --local root = parser:parse()[1].root()

  --local text = vim.inspect(#root)
  --local text = string.format("a %s", #root)
  M.put_text(parser)
  --- -- Get the node at the given position
  --- local node = tree:root():descendant_for_position({
  ---   row = line,
  ---   column = col
  --- })

  --- -- Print the node's type and range
  --- print(string.format("Node type: %s, Range: %d-%d",
  ---   node:type(), node:start_position().row, node:end_position().row))
end

M.put_text_init = function(buf)
  vim.api.nvim_buf_set_lines(bufnr_output, 0, -1, false, { '-----' })
end

M.put_text = function(text)
  local lines = {}
  if text and #text > 0 then
    for s in text:gmatch '[^\r\n]+' do
      table.insert(lines, s)
    end
  else
    lines = { 'error' }
  end
  vim.api.nvim_buf_set_lines(bufnr_output, -1, -1, false, lines)
end

M.test = function()
  M.put_text_init()
  M.main()
end

function M.main()
  local line, col = M.get_def_position()
  if not line or not col then
    return
  end

  --2 M.get_node_at_position(17, 1)
  local cursor = { line - 1, col }
  local node = M.get_node_at_pos(cursor)
  local text = M.node_toString(node)
  M.put_text(text)
end
function M.node_toString(node)
  if node then
    -- return vim.treesitter.query.get_node_text(node_of_function, 0, {})[1]
    return require('nvim-treesitter.ts_utils').get_node_text(node, 0, {})[1]
  end
end
function M.get_node_at_pos(cursor)
  local parsers = require 'nvim-treesitter.parsers'
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local cursor_range = { cursor[1] - 1, cursor[2] }

  local buf = vim.api.nvim_win_get_buf(0)
  local root_lang_tree = parsers.get_parser(buf)
  if not root_lang_tree then
    return
  end
  local root = ts_utils.get_root_for_position(cursor_range[1], cursor_range[2], root_lang_tree)

  if not root then
    return
  end

  return root:named_descendant_for_range(cursor_range[1], cursor_range[2], cursor_range[1], cursor_range[2])
end

return M
