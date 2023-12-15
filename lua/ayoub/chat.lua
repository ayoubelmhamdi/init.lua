local M = {}

function M.mktemp()
    local tmpname = os.tmpname()
    local tmpfile = io.open(tmpname, 'w')
    tmpfile:close()
    return tmpname
end

function M.writetofile(filename, lines)
    local file = io.open(filename, 'w')
    for _, line in ipairs(lines) do
        file:write(line .. '\n')
    end
    file:close()
end

function M.ask(bufnr, engine, all_lines)
    local command = {}
    if engine == 'Bing' or engine == 'client-embedding' or engine == 'bing3' or 'askbing' then
        local tmpname = M.mktemp()
        M.writetofile(tmpname, all_lines)
        command = { engine, tmpname }
    else
        local text = table.concat(all_lines, '\n')
        command = { engine, '-m', text }
    end

    local append_data = function(_, data)
        if data then vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data) end
    end
    local notify = function(_, data)
        vim.fn.jobstart({ 'notify-send', 'title:', engine .. ' finished' }, {
            stdout_buffered = false,
        })
    end

    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { '# ---' .. engine .. '----' })
    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
        on_exit = notify,
    })
end

M.nvim_get_selected_text = function(bufnr)
    local from_pos, to_pos = vim.fn.getpos("'<"), vim.fn.getpos("'>")
    local from, to = { line = from_pos[2], col = from_pos[3] }, { line = to_pos[2], col = to_pos[3] }
    -- Tweak for linewise Visual selection
    if vim.fn.visualmode() == 'V' then
        from.col, to.col = 1, vim.fn.col({ to.line, '$' }) - 1
    end

    local lines = vim.api.nvim_buf_get_text(bufnr, from.line - 1, from.col - 1, to.line - 1, to.col, {})
    return lines or {}
end

M.main = function(engine)
    local bufnr = vim.api.nvim_get_current_buf()
    if not engine then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { '# ---no-engine----' })
        return
    end

    local all_lines = {}
    all_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
    -- TODO: check the methode that use substute with lua sub()
    -- becase i have many error when using this
    -- if vim.fn.visualmode() ~= 'V' or vim.fn.visualmode() ~= 'V' then
    --   all_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
    -- else
    --   all_lines = M.nvim_get_selected_text(bufnr)
    -- end

    M.ask(bufnr, engine, all_lines)
end

return M
