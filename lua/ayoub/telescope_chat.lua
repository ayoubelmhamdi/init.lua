local M = {}

---- TODO:  toggle between list/dictionary telescope_insert("numbers", dict=true)
----        then for dict view key in left and value in preview wndows

M.prompts = { 'In neovim with Lua API, ', 'apple', 'car', '1' }
M.numbers = { '1', '2', '3' }
M.telescope_insert = function(list_name)
  if not list_name then
    print 'no args... exit'
    return
  end
  local list = {}
  if list_name == 'prompts' then
    list = M.prompts
  elseif list_name == 'numbers' then
    list = M.numbers
  else
    print 'args not trouve... exit'
    return
  end

  local actions = require 'telescope.actions'
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local action_state = require 'telescope.actions.state'
  local opts = {}
  pickers
      .new(opts, {
        prompt_title = 'Pick a prompt',
        finder = finders.new_table {
          results = list,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.api.nvim_put({ selection[1] }, '', false, true)
          end)
          return true
        end,
      })
      :find()
end

return M
