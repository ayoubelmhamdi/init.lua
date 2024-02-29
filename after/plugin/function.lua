P = function(v)
    print(type(v))
    local v_type = type(v)
    if v_type == 'number' or v_type == 'string' or v_type == 'boolean' then
        print(v)
    elseif v_type == 'function' then
        print(vim.inspect(v))
    else -- v_type == 'userdata'
        print(vim.inspect(getmetatable(v)))
    end
end

RELOAD = function(...) return require('plenary.reload').reload_module(...) end

R = function(name)
    RELOAD(name)
    return require(name)
end

-- FormatFunction = function()
--     print("start formating")
--     vim.lsp.buf.format({
--         async = true,
--         range = {
--             ['start'] = vim.api.nvim_buf_get_mark(0, '<'),
--             ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
--         },
--     })
-- end
