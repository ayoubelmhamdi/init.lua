local M = {}
local c = {}

-- TODO: remove the table because maybe i don;t want it, the c.bullet_highlights should interpreted using string, and c.headline_highlights highit directly using `hi  @markup.heading.1.markdown`
c.headline_highlights = {
    'Headline1',
    'Headline2',
    'Headline3',
    'Headline4',
    'Headline5',
    'Headline6',
}
c.bullet_highlights = {
    'Bullet1',
    'Bullet2',
    'Bullet3',
    'Bullet4',
    'Bullet5',
    'Bullet6',
}
c.bullets = { '✸', '◉', '○', '✸' }

local query = vim.treesitter.query.parse(
    'markdown',
    [[
    (atx_heading [
      (atx_h1_marker) @headline1
      (atx_h2_marker) @headline2
      (atx_h3_marker) @headline3
      (atx_h4_marker) @headline4
      (atx_h5_marker) @headline5
      (atx_h6_marker) @headline6
    ])
  ]]
)

local language = vim.bo.filetype
M.ns_id = vim.api.nvim_create_namespace('headlines_namespace')

M.refresh = function()
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
                local start_row, start_column, end_row, end_column = unpack(vim.tbl_extend('force', { node:range() }, (metadata[id] or {}).range or {}))

                local level = tonumber(capture:sub(-1)) or 1
                local bullet = c.bullets[level]
                local bullet_hl_group = c.bullet_highlights[level]
                local hl_group = c.headline_highlights[level]
                local bullet_len = string.len(bullet)
                local virt_text = {}
                if c.bullets and #c.bullets > 0 then
                    local bullet = c.bullets[((level - 1) % #c.bullets) + 1]
                    virt_text[1] = { string.rep(' ', level - 1) .. bullet, { hl_group, bullet_hl_group } }
                end

                local extmark_id = vim.api.nvim_buf_set_extmark(bufnr, M.ns_id, start_row, start_column, {
                    virt_text = virt_text,
                    virt_text_pos = 'overlay',
                    end_line = start_row,
                    end_col = end_column,
                })
            end
        end
    end
end

return M
