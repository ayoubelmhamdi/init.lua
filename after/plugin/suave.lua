if true then
  return
end
local suave = require 'suave'
suave.setup {
  -- split_on_top = true,
  -- menu_height = 13,
  store_hooks = {
    before_mksession = {
      function()
        -- for _, w in ipairs(vim.api.nvim_list_wins()) do
        --   if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(w), 'ft') == 'neo-tree' then
        --     vim.api.nvim_win_close(w, false)
        --   end
        -- end
      end,
      function() end,
    },
    after_mksession = {},
  },
  restore_hooks = {
    before_source = {},
    after_source = {},
  },
}

-- Uncomment the following lines to enable project session automation
-- NOTE: if you always call `tcd` instead of `cd` on all tabpages,
--       you can stay in the current project and suave.lua will remember these paths.
-- NOTE: the `vim.fn.argc() == 0` is required to exclude `git commit`.
-- NOTE: the `not vim.v.event.changed_window` is required to exclude `:tabn`,`:tabp`.
--
-- vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
--   group = 'session.lua',
--   pattern = '*',
--   callback = function()
--     if
--       vim.fn.argc() == 0 -- not git
--       and not vim.v.event.dying -- safe leave
--     then
--       suave.store_session(true)
--     end
--   end,
-- })
vim.api.nvim_create_autocmd({ 'DirChangedPre' }, {
  group = 'session.lua',
  pattern = 'global',
  callback = function()
    if
      vim.fn.argc() == 0 -- not git
      and not vim.v.event.changed_window -- it's cd
    then
      suave.store_session(true)
    end
  end,
})
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  group = 'session.lua',
  pattern = '*',
  callback = function()
    if
      vim.fn.argc() == 0 -- not git
    then
      suave.restore_session(true)
    end
  end,
})
vim.api.nvim_create_autocmd({ 'DirChanged' }, {
  group = 'session.lua',
  pattern = 'global',
  callback = function()
    if
      vim.fn.argc() == 0 -- not git
      and not vim.v.event.changed_window -- it's cd
    then
      suave.restore_session(true)
    end
  end,
})
