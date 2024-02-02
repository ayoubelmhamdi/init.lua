local M = {}
function M.node_at_pos(start_line, start_col, buf)
    buf = buf or vim.api.nvim_get_current_buf()
    start_col = start_col - 1

    local tree = vim.treesitter.get_parser()

    if not tree then return nil end

    local parse = tree:parse()
    local root = parse[1]:root()
    local node = root:descendant_for_range(start_line, start_col, start_line, start_col)

    return node
end

M.main = function()
    P(M.node_at_pos(1, 1):end_())
end

M.print_function_info = function()
    -- Get the current buffer and its Tree-sitter parser
    local bufnr = vim.api.nvim_get_current_buf()
    local tree = vim.treesitter.get_parser(bufnr, 'c')

    if not tree then return nil end

    local root = tree:parse()[1]:root()

    local query = vim.treesitter.query.parse(
        'c',
        [[
        (function_definition
            declarator: (function_declarator
                        declarator: (identifier) @function.name)
            body: (compound_statement 
                    (return_statement) @function.return) @function.body)
        ]]
    )
    for _, captures in query:iter_matches(root, bufnr) do
        local function_name_node = captures[1]
        local function_body_node = captures[2]
        local return_node = captures[3]

        -- Check if the nodes exist before trying to use them
        if function_name_node and function_body_node then
            -- Extract and print function definition range and name
            local s_row, s_col, e_row, e_col = function_body_node:range()
            print(string.format('function_definition [%d, %d] - [%d, %d]', s_row + 1, s_col, e_row + 1, e_col))
            print('identifier', vim.treesitter.get_node_text(function_name_node, bufnr))
        -- else
        --     print('Error: Missing function name or body node')
        end

        -- If there's a return statement, print its range
        if return_node then
            local rs_row, rs_col, re_row, re_col = return_node:range()
            print(string.format('return [%d, %d] - [%d, %d]', rs_row + 1, rs_col, re_row + 1, re_col))
        end
        print('------\n')
    end

end

return M
