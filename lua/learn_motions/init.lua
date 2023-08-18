local M = {}

function M.highlight_next_letter()
  if _G.Match_id then
    local status, err = pcall(vim.fn.matchdelete, _G.Match_id)
    if not status then
      print('Error deleting match: ', err)
    end
  end

  local position = vim.api.nvim_win_get_cursor(0)
  local row = position[1] - 1
  local col = position[2]

  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  if not line or line == '' then
    -- The line is empty.
    return
  end
  -- local word_start, word_end = line:find("[%w_]+", col)
  local word_start, word_end = line:find('[%w_]+', col)
  if word_start == nil then
    print 'word_start is nil'
    return
  end
  if word_end == nil then
    print 'word_start is nil'
    return
  end
  local no_word = '...'
  -- if true then
  --   return
  -- end

  if col + 1 > word_end then
    -- no_word = 'max error'

    -- The cursor is not in a word. Find the last letter in the next word or symbol.
    word_start, word_end = line:find('[%w%s_]+', col)
    if not word_start or not word_end then
      -- There is no next word or symbol.
      return
    end
  else
    if col + 1 == word_end then
      no_word = 'end_of_word'
      -- else
      --   if col + 1 < word_end then
      --     -- The cursor is in the middle of a word. Move it to the next character.
      --     -- print("word-middle")
      --     word_start = col + 2
      --   else
      --     -- print("word-end")
      --     -- The cursor is at the end of a word.
      --     -- Search for the next word or symbol after skipping spaces.
      word_start, word_end = line:find('[^%s]+', word_end + 1)
      if not word_start then
        -- There is no next word or symbol.
        return
      end

      if col + 1 > word_end then
        word_start, word_end = line:find('[%w%s_]+', col)
        if not word_start or not word_end then
          -- There is no next word or symbol.
          return
        end
      end
    end
  end

  if col + 1 > word_end then
    no_word = 'max search for next char or last letter'
  end

  if col + 1 < word_start then
    no_word = 'min ok'
    -- TODO: .[From].[expected] '}, { col[To]:
  end

  print(no_word .. ' { start: ' .. word_start .. '}, { col: ' .. col + 1 .. '},{ end: ' .. word_end .. '}')

  vim.cmd 'hi RedLetter guifg=red ctermfg=red'
  _G.Match_id = vim.fn.matchaddpos('RedLetter', { { row + 1, word_end, 1 } })
end

return M
