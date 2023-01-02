-----
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = {
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
  },
  callback = function()
    vim.cmd [[noautocmd up]]
  end,
})

-- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
--   pattern = { '*.rs', '*.lua' },
--   callback = function()
--     vim.cmd [[silent! lua require("gg").view_function()]]
--   end,
-- })

vim.api.nvim_create_autocmd('BufWrite', {
  pattern = { '*.c' },
  callback = function()
    vim.lsp.buf.format { async = true }
  end,
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = { '*.dart' },
  callback = function()
    os.execute 'killflutter'
  end,
})

-- highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 300,
      on_visual = true,
    }
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
