--

local pattern = {
  '*.css',
  '*.html',
  '*.js',
  '*.md',
  '*.tex',
  '*.c',
  '*.h',
  '*.lua',
  '*.dart',
  '*.rs',
  '*.sh',
  '*.toml',
  '*.yaml',
  '*.m',
}

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = pattern,
  callback = function()
    vim.cmd [[noautocmd update]]
  end,
})

-- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
--   pattern = { '*.rs', '*.lua' },
--   callback = function()
--     vim.cmd [[silent! lua require("gg").view_function()]]
--   end,
-- })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = pattern,
  callback = function()
    vim.lsp.buf.format { async = true }
  end,
})

-- useful for some zf
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = pattern,
  callback = function()
    vim.cmd [[silent! loadview]]
  end,
})

vim.api.nvim_create_autocmd('VimLeave', {
  pattern = pattern,
  callback = function()
    vim.cmd [[silent! mkview]]
  end,
})

-- use custom shell for reload flutter using kill
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = { '*.dart' },
  callback = function()
    os.execute 'killflutter'
  end,
})

local place_sign = require('ayoub.signs').place_sign
local unplace_sign = require('ayoub.signs').unplace_sign

local api = vim.api
local group = 'CursorSign'

api.nvim_create_augroup(group, { clear = true })

vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
  pattern = '*',
  group = group,
  callback = function()
    local line, _ = unpack(api.nvim_win_get_cursor(0))
    unplace_sign(1)
    place_sign(line, 1)
  end,
})

vim.cmd [[

augroup General
  autocmd!
  autocmd BufWritePost       *.sh,*.pl,*.py silent !chmod +x %
  autocmd BufNewFile,BufRead *.m3u          set encoding=utf-8 fileencoding=utf-8 ff=unix
  autocmd BufWinEnter        SUMMARY.md     set nowrap
  autocmd BufRead,BufNewFile *.conf         setfiletype bash
  autocmd BufRead,BufNewFile *.fish         setfiletype fish
  autocmd BufWritePost       X{resources,defaults} silent !xrdb %
  autocmd FileType           txt,markdown,asciidoc*,rst if &filetype !~ 'man\|help' | setlocal spell spelllang=fr,en_us | endif
  autocmd FileType           help,man,startuptime,qf,lspinfo,checkhealth nnoremap <buffer><silent>q :bdelete<CR>
augroup END

" autocmd BufWinEnter        * if &previewwindow | setlocal nofoldenable | endif

augroup Help
  autocmd!
  autocmd BufWinEnter * if &filetype =~ 'help' | wincmd L | vertical resize 84 | endif
  autocmd BufWinEnter * if &filetype =~ 'man' | wincmd L | wincmd = | endif
  autocmd FileType man,help,*doc setlocal nonumber norelativenumber nospell nolist nocursorcolumn
augroup END
]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local AyoubGroup = augroup('Ayoub', {})
local yank_group = augroup('HighlightYank', {})

function R(name)
  require('plenary.reload').reload_module(name)
end

-- highlight text on yank
autocmd('TextYankPost', {
  group = yank_group,
  pattern = pattern,
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 300,
    }
  end,
})

autocmd({ 'BufWritePre' }, {
  group = AyoubGroup,
  pattern = pattern,
  command = '%s/\\s\\+$//e',
})

--1vim.keymap.set('n', '<space>s', function()
--1  package.loaded.gg = nil
--1  -- vim.cmd 'w'
--1  R 'vf'
--1  require('vf').view_function()
--1end, {})
--1
--1vim.keymap.set('n', '<space>e', function()
--1  require('vf').view_function()
--1end, {})

local group_no_name = vim.api.nvim_create_augroup('delete_no_name_buffers', { clear = true })

-- Create an autocommand to delete buffers with the name '[No Name]'
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNew' }, {
  pattern = '*',
  group = group_no_name,
  callback = function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname == '' then
        vim.bo[bufnr].bufhidden = 'delete'
      end
    end
  end,
})

local group_hi_last_letter = vim.api.nvim_create_augroup('group_hi_last_letter', { clear = true })

-- Create an autocommand to delete buffers with the name '[No Name]'
vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
  pattern = pattern,
  group = group_hi_last_letter,
  callback = function()
    -- require('learn_motions').highlight_last_letter()
    require('learn_motions').highlight_next_letter()
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
