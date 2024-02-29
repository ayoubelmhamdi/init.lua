local M = {}
-- Define the query and the language_tree as local variables
-- Use the new treesitter API to parse the query
local query = vim.treesitter.query.parse(
    'markdown',
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

M.create_heading_keyword = function()
    local bullets = { '◉', '○', '✸', '✿' }
    local bufnr = vim.api.nvim_get_current_buf()
    -- Use the new treesitter API to get the query
    -- local language_tree = vim.treesitter.query.get(0, language)
    -- local syntax_tree = language_tree:parse()
    -- local root = syntax_tree[1]:root()


    local language_tree = vim.treesitter.get_parser(0, language)
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[1]:root()

    -- Use a for loop to iterate over the syntax_tree
    for _, tree in ipairs(syntax_tree) do
        local root = tree:root()
        for _, match, metadata in query:iter_matches(root, bufnr) do
            for id, node in pairs(match) do
                local capture = query.captures[id]
                local start_row, start_column, end_row, end_column = unpack(vim.tbl_extend('force', { node:range() }, (metadata[id] or {}).range or {}))

                if capture == 'headline' then
                    print("ici")
                    -- Get the heading level by checking the node's type
                    -- local level = tonumber(node:type():sub(-1))
                    local level = tonumber(node:type():match("%d$")) or 1
                    -- Get the bullet symbol and the highlight group for this level
                    local bullet = bullets[level]
                    local hl_group = 'HeadingBullet' .. level
                    -- Replace the heading marker with the bullet symbol and a space
                    -- Use the node's end_column instead of the metadata's end_column
                    vim.api.nvim_buf_set_text(bufnr, start_row, start_column, start_row, end_column, { bullet .. ' ' })

                    -- Optionally, add some highlighting to the bullet symbol
                    -- You need to define the highlight groups in your colorscheme
                    vim.api.nvim_buf_add_highlight(bufnr, -1, hl_group, start_row, start_column, start_column + #bullet)
                end
            end
        end
    end
end
return M
