local M = {}

function M.highlight_next_letter()
    if _G.Match_id then pcall(vim.fn.matchdelete, _G.Match_id)         --   debug
        --   print('Error deleting match: ', err)
        --   do not return if we dont has _G.Match_id
        --   just delet it if exist
end

    local position = vim.api.nvim_win_get_cursor(0)
    local row = position[1] - 1
    local col = position[2]

    local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    if not line or line == '' then
        -- The line is empty.
        return
    end
    local word_start, word_end = line:find('[%w_]+', col)
    if word_start == nil then
        print('word_start is nil')
        return
    end
    if word_end == nil then
        print('word_start is nil')
        return
    end
    local no_word = '...'

    -- TODO check if cursor under %w or not

    -- word [cursor]
    if col + 1 > word_end then
        word_start, word_end = line:find('[%w%s_]+', col)
        if not word_start or not word_end then return end
    else
        -- else if
        -- word[cursor]
        if col + 1 == word_end then
            no_word = 'end_of_word'
            word_start, word_end = line:find('[^%s]+', word_end + 1)
            if not word_start then
                -- There is no next word or symbol.
                return
            end

            if col + 1 > word_end then
                word_start, word_end = line:find('[%w%s_]+', col)
                if not word_start or not word_end then return end
            end
        else
            -- wor[cursor]d or [cursor] word
        end
        -- else if fin
    end

    -- check again
    if col + 1 > word_end then no_word = 'max search for next char or last letter' end

    if col + 1 < word_start then no_word = 'min ok'         -- TODO: .[From].[expected] '}, { col[To]:
end

    --debug
    --print(no_word .. ' { start: ' .. word_start .. '}, { col: ' .. col + 1 .. '},{ end: ' .. word_end .. '}')

    vim.cmd('hi RedLetter guifg=red ctermfg=red')
    _G.Match_id = vim.fn.matchaddpos('RedLetter', { { row + 1, word_end, 1 } })
end

return M
