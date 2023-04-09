require 'ayoub'

vim.keymap.set('n', '<space>s', function()
  package.loaded.gg = nil
  -- vim.cmd 'w'
  R 'vf'
  require('vf').view_function()
end, {})

vim.keymap.set('n', '<space>e', function()
  require('vf').view_function()
end, {})
--
-- Create an autocommand group
local group = vim.api.nvim_create_augroup('delete_no_name_buffers', { clear = true })

-- Create an autocommand to delete buffers with the name '[No Name]'
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNew' }, {
  pattern = '*',
  group = group,
  callback = function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname == '' then
        vim.bo[bufnr].bufhidden = 'delete'
      end
    end
  end,
})

--1 ---- Define a function to move a buffer to a new tab
--1 local function move_to_new_tab(bufnr)
--1   local buffer_name = vim.api.nvim_buf_get_name(bufnr)
--1
--1   if buffer_name ~= nil or buffer_name ~= '' then
--1     if vim.bo.buflisted and vim.bo.buftype ~= 'terminal' then
--1       -- vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'delete')
--1       -- vim.api.nvim_command 'tabnew'
--1       -- vim.api.nvim_command('edit ' .. buffer_name)
--1       -- vim.api.nvim_command('bd ' .. bufnr)
--1       -- -- vim.schedule(function()
--1       -- --   vim.api.nvim_command('edit ' .. api.nvim_buf_get_name(bufnr))
--1       -- -- end)
--1       vim.api.nvim_buf_set_name(bufnr, " " .. buffer_name)
--1       vim.api.nvim_command 'tabnew'
--1       vim.api.nvim_command('buffer ' .. bufnr)
--1       -- vim.api.nvim_command('bd ' .. bufnr)
--1     end
--1   end
--1 end
--1
--1 local group = vim.api.nvim_create_augroup('MoveHiddenBuffersToNewTab', { clear = true })
--1 vim.api.nvim_create_autocmd('BufLeave', {
--1   pattern = '*',
--1   callback = function()
--1     -- # move to new tab
--1     local bufnr = vim.api.nvim_get_current_buf()
--1     -- # prevent to hidden
--1     move_to_new_tab(bufnr)
--1     -- for _, buffer in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
--1     --   vim.api.nvim_buf_set_option(buffer.bufnr, 'bufhidden', 'delete')
--1     -- end
--1   end,
--1   group = group,
--1 })
