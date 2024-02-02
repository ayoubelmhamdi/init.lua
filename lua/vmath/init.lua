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

M.main = function() P(M.node_at_pos(1, 1):end_()) end

M.print_function_info = function()
    -- Get the current buffer and its Tree-sitter parser
    local bufnr = vim.api.nvim_get_current_buf()
    local tree = vim.treesitter.get_parser(bufnr, 'c')

    if not tree then return nil end

    local root = tree:parse()[1]:root()

    local query = vim.treesitter.query.parse(
        'c',
        [[
        ((function_definition
            declarator: (function_declarator
                        declarator: (identifier) @name
                        parameters: (parameter_list) @args)
            body: (compound_statement (return_statement (binary_expression) @return))
                        )@function)
        ]]
    )

    local list = {}
    for _, captures, _ in query:iter_matches(root, bufnr) do
        local function_name_node = captures[1]
        local function_args_node = captures[2]
        local function_return_node = captures[3]
        local function_body_node = captures[4]

        if function_name_node and function_args_node and function_return_node and function_body_node then
            local s_row, _, e_row, _ = function_body_node:range()
            local args = {}
            for child in function_args_node:iter_children() do
                -- Check if the child node is a parameter_declaration
                if child:type() == 'parameter_declaration' then
                    -- Iterate over the children of the parameter_declaration
                    for parameter_child in child:iter_children() do
                        -- Check if the child node is an identifier
                        if parameter_child:type() == 'identifier' then
                            local arg_name = vim.treesitter.get_node_text(parameter_child, bufnr)
                            table.insert(args, arg_name)
                        end
                    end
                end
            end
            local func_info = {
                a_name = vim.treesitter.get_node_text(function_name_node, bufnr),
                b_args = args,
                c_return_ = function_return_node and vim.treesitter.get_node_text(function_return_node, bufnr) or nil,
                d_start = s_row,
                e_end_ = e_row + 1,
            }
            table.insert(list, func_info)
        end
        -- break
    end
    vim.print(list)
end

return M
