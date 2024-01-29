function R(name) require('plenary.reload').reload_module(name) end

vim.cmd([[

augroup restore_pos |
  au!
  au BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\"zz"
      \ | endif
augroup end


augroup General
  autocmd!
  autocmd BufWritePost       *.sh,*.pl,*.py silent !chmod +x %
  autocmd BufWinEnter        SUMMARY.md     set nowrap
  autocmd BufRead,BufNewFile *.conf,*/conf  setfiletype bash
augroup END

augroup Help
  autocmd!
  autocmd FileType help,man,startuptime,qf,lspinfo,checkhealth nnoremap <buffer><silent>q :bdelete<CR> | setlocal spell spelllang=fr,en_us nonumber norelativenumber nospell nolist nocursorcolumn | vertical resize 90
augroup END


augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* execute "normal! zz" | cwindow
    autocmd QuickFixCmdPost    l* execute "normal! zz" | lwindow
    autocmd FileType qf,jf nnoremap <buffer> <CR> <CR>:cclose<CR>
augroup END

]])


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
    group = vim.api.nvim_create_augroup('AutoWriteMybuf', { clear = true }),
    pattern = pattern,
    callback = function() vim.cmd([[noautocmd update]]) end,
})

-- useful for some zf
vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('LoadMyView', { clear = true }),
    pattern = pattern,
    callback = function() vim.cmd([[silent! loadview]]) end,
})

vim.api.nvim_create_autocmd('VimLeave', {
    group = vim.api.nvim_create_augroup('SaveMyView', { clear = true }),
    pattern = pattern,
    callback = function() vim.cmd([[silent! mkview]]) end,
})

-- use custom shell for reload flutter using kill
vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
    group = vim.api.nvim_create_augroup('Flutter', { clear = true }),
    pattern = { '*.dart' },
    callback = function() vim.cmd('silent! !killflutter') end,
})

local place_sign = require('ayoub.signs').place_sign
local unplace_sign = require('ayoub.signs').unplace_sign

vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
    pattern = '*',
    group = vim.api.nvim_create_augroup('CursorSign', { clear = true }),
    callback = function()
        local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
        unplace_sign(1)
        place_sign(line, 1)
    end,
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { 'dwm.c', 'nn.h' },
    group = vim.api.nvim_create_augroup('Cmain', {}),
    callback = function()
        vim.cmd('make | redraw! |echo "make finished"')
        vim.cmd('silent! !ctags -f tags dwm.c config.def.h &')
    end,
})


-- highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('HighlightYank', {}),
    pattern = pattern,
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 300,
        })
    end,
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


-- Create an autocommand to delete buffers with the name '[No Name]'
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNew' }, {
    pattern = '*',
    group = vim.api.nvim_create_augroup('delete_no_name_buffers', { clear = true }),
    callback = function()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname == '' then vim.bo[bufnr].bufhidden = 'delete' end
        end
    end,
})
