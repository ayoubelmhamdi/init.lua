-- for neovim with lua API, using the telescope.nvim plugin, i want to create a module called M, this module, preview all file in directory /path/dir, then  selected one file from this directory to insert it cursor position using telecope API.
-- use telescope insert methode
-- create one function called M.preview_files()

local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
local conf = require('telescope.config').values
local action_state = require 'telescope.actions.state'
local previewers = require 'telescope.previewers'

local M = {}

function M.manual_previewer(cwd)
  return previewers.new_buffer_previewer {
    define_preview = function(self, entry)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.fn.readfile(cwd .. entry.value))
    end,
  }
end

function M.preview_files(opts)
  local cwd = '/data/chat/telescope/' -- last slash is importannt for `find` command
  opts = opts or {}

  -- pickers.new(opts, { previewer = conf.grep_previewer(opts) }):find()
  pickers
    .new({}, {
      cwd = cwd,
      previewer = M.manual_previewer(cwd),
      prompt_title = 'Files',
      -- finder = finders.new_oneshot_job { 'ls', '-1', '/data/prompts' },
      finder = require('telescope.finders').new_oneshot_job({ 'find', '-type', 'f' }, { cwd = cwd }),
      sorter = conf.file_sorter {},
      -- layout_strategy = 'vertical',
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          -- print(selection.value)
          actions.close(prompt_bufnr)
          local content = vim.fn.readfile(cwd .. selection.value)

          -- vim.api.nvim_buf_set_lines(buf, -1, -1, false, content)
          vim.api.nvim_put(content, '', false, true)
        end)

        return true
      end,
    })
    :find()
end

return M
