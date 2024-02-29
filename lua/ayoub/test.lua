local M = {}
-- Define the query and the language_tree as local variables
-- Use the new treesitter API to parse the query
local query = vim.treesitter.query.parse(
  "markdown",
  [[
    (atx_heading [
      (atx_h1_marker)
      (atx_h2_marker)
      (atx_h3_marker)
      (atx_h4_marker)
      (atx_h5_marker)
      (atx_h6_marker)
    ] @headline)
  ]]
)
local language = vim.bo.filetype
M.ns_id = vim.api.nvim_create_namespace "headlines_namespace"

M.create_heading_keyword = function()
  local bullets = { "◉", "○", "✸", "✿" }
  local bufnr = vim.api.nvim_get_current_buf()
  local language_tree = vim.treesitter.get_parser(bufnr, language)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()

  -- Use a for loop to iterate over the syntax_tree
  for _, tree in ipairs(syntax_tree) do
    local root = tree:root()
    for _, match, metadata in query:iter_matches(root, bufnr) do
      for id, node in pairs(match) do
        local capture = query.captures[id]
        local start_row, start_column, end_row, end_column =
          unpack(vim.tbl_extend("force", { node:range() }, (metadata[id] or {}).range or {}))

        if capture == "headline" then
          -- Get the heading level by checking the node's type
          local level = tonumber(node:type():sub(-1)) or tonumber(node:type():match("%d$")) or 1
          -- Get the bullet symbol and the highlight group for this level
          local bullet = bullets[level]
          local hl_group = "HeadingBullet" .. level
          -- Create a virtual text with the bullet symbol and a space
          -- Use the node's end_column instead of the metadata's end_column
          local extmark_id = vim.api.nvim_buf_set_extmark(bufnr, M.ns_id, start_row, start_column, {
            virt_text = {{ bullet .. " ", hl_group }},
            virt_text_pos = "overlay",
            end_line = start_row,
            end_col =end_colum,
          })
          -- Optionally, add some highlighting to the bullet symbol
          -- You need to define the highlight groups in your colorscheme
          vim.api.nvim_buf_add_highlight(bufnr, -1, hl_group, start_row, start_column, start_column + #bullet)
          -- Hide the original text with neovim virtual text
          -- Use the metadata's end_column instead of the node's end_column
          vim.api.nvim_buf_set_virtual_text(bufnr, 0, start_row, {{string.rep(" ", end_column - start_column), hl_group}}, {})
        end
      end
    end
  end
end
return M
