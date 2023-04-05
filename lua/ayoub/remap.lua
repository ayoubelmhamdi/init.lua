vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<leader>vwm', function()
  require('vim-with-me').StartVimWithMe()
end)
vim.keymap.set('n', '<leader>svwm', function()
  require('vim-with-me').StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set('x', '<leader>p', '"_dP')

-- next greatest remap ever : asbjornHaland
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format()
end)

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

vim.keymap.set('n', '<space><space>', ':w<cr>:silent !python -m jupyter_ascending.requests.sync --filename %&:<cr>', { silent = true })
vim.keymap.set('n', '<c-w>o', ':Zoom<cr>', { silent = true })

vim.keymap.set('n', 'x', '"_x', { silent = true })
vim.keymap.set('n', 'X', '"_X', { silent = true })
vim.keymap.set('n', 'c', '"_c', { silent = true })
vim.keymap.set('n', 'C', '"_C', { silent = true })

vim.keymap.set('v', 'x', '"_x', { silent = true })
vim.keymap.set('v', 'X', '"_X', { silent = true })
vim.keymap.set('v', 'c', '"_c', { silent = true })
vim.keymap.set('v', 'C', '"_C', { silent = true })

vim.keymap.set('v', 'y', 'ygv<Esc>', { silent = true })
vim.keymap.set('v', 'Y', 'Ygv<Esc>', { silent = true })

vim.keymap.set('v', 'p', 'pgvy', { silent = true })
vim.keymap.set('v', 'P', 'Pgvy', { silent = true })

vim.keymap.set('n', ',or', ':OverseerRun<cr>', { silent = true })
vim.keymap.set('n', ',ol', ':OverseerLoadBundle<cr>', { silent = true })
-- vim.keymap.set("n", ",ot", ":OverseerTaskAction<cr>", { silent = true })
vim.keymap.set('n', ',oq', ':OverseerQuickAction<cr>', { silent = true })
vim.keymap.set('n', ',ov', ':OverseerQuickAction open vsplit<cr>', { silent = true })
vim.keymap.set('n', ',ow', ':OverseerQuickAction watch<cr>', { silent = true })

vim.keymap.set('n', 'q:', ':q', { silent = true })

vim.keymap.set('n', '<Space>fs', ':Telescope current_buffer_fuzzy_find<cr>', { silent = true })
vim.keymap.set('n', '<Space>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { silent = true })
vim.keymap.set('n', '<Space>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { silent = true })
vim.keymap.set('n', '<Space>hh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', { silent = true })
vim.keymap.set(
  'n',
  '<Space>ff',
  '<cmd>lua require("telescope.builtin").find_files({ find_command = { "fd","-tf","-tl"}})<cr>',
  { silent = true }
)

vim.keymap.set('n', '<Space>fh', ' <cmd>:lua require("harpoon.ui").toggle_quick_menu()<cr>', { silent = true })
vim.keymap.set('n', '<Space>fa', ' <cmd>:lua require("harpoon.mark").add_file()<cr>', { silent = true })
vim.keymap.set('n', '<Space>fn', ' <cmd>:lua require("harpoon.ui").nav_next()<cr>', { silent = true })
vim.keymap.set('n', '<Space>fp', ' <cmd>:lua require("harpoon.ui").nav_prev()<cr>', { silent = true })

vim.keymap.set('n', '<Space>f.', ':lua require("tsp.cwd-tsp").search_dotfiles()<cr> ', { silent = true })
vim.keymap.set('n', '<Space>f-', ':lua require("tsp.cwd-tsp").search_nvim()<cr> ', { silent = true })
vim.keymap.set('n', '<Space>fw', ':lua require("tsp.cwd-tsp").search_wiki()<cr> ', { silent = true })
vim.keymap.set('n', '<Space>f1', ':lua require("tsp.cwd-tsp").search_proj("sl")<cr> ', { silent = true })
vim.keymap.set('n', '<Space>f2', ':lua require("tsp.cwd-tsp").search_proj("slstatus")<cr> ', { silent = true })

vim.keymap.set('n', '<Tab>', '     :tabnext<cr>', { silent = true })
vim.keymap.set('n', '<S-Tab>', '   :tabprev<cr>', { silent = true })

vim.keymap.set('i', '<c-a-k>', '<c-k>', { silent = true })

vim.keymap.set('n', '<up>', 'k<c-y>', { silent = true })
vim.keymap.set('n', '<down>', 'j<c-e>', { silent = true })

vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n><esc>', { silent = true })
vim.keymap.set('t', '<Tab>', '<c-\\><c-n>:tabnext<cr>', { silent = true })
vim.keymap.set('t', '<S-Tab>', '<c-\\><c-n>:tabprev<cr>', { silent = true })

vim.keymap.set('n', '<C-Up>', ':resize +2<cr>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<cr>', { silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<cr>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<cr>', { silent = true })

vim.keymap.set('t', '<C-Up>', '<C-\\><C-N>:resize +2<cr>', { silent = true })
vim.keymap.set('t', '<C-Down>', '<C-\\><C-N>:resize -2<cr>', { silent = true })
vim.keymap.set('t', '<C-Left>', '<C-\\><C-N>:vertical resize -2<cr>', { silent = true })
vim.keymap.set('t', '<C-Right>', '<C-\\><C-N>:vertical resize +2<cr>', { silent = true })

--Basic file system commands
vim.keymap.set('n', '<C-M-o>', ':!touch<Space>', { silent = true })
vim.keymap.set('n', '<C-M-d>', ':!mkdir<Space>', { silent = true })
vim.keymap.set('n', '<C-M-c>', ':!cp<Space>%<Space>', { silent = true })
vim.keymap.set('n', '<C-M-m>', ':!mv<Space>%<Space>', { silent = true })

-- fix p y
--vim.keymap.set('n', 's', '<NOP>', {silent = true})
--vim.keymap.set('n', 'S', '<NOP>', {silent = true})
vim.keymap.set('n', '<C-Q>', '     :noautocmd bd<cr>', { silent = true })
vim.keymap.set('n', '<C-Q><C-Q>', ':noautocmd q<cr>', { silent = true })
vim.keymap.set('n', '<Space>w', '  :w<cr>', { silent = true })

vim.keymap.set('n', '>', 'v>', { silent = true })
vim.keymap.set('n', '<', 'v<', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })
vim.keymap.set('v', '<', '<gv', { silent = true })

vim.keymap.set('i', '<A-a>', '<Right>', { silent = true })
vim.keymap.set('i', '<A-i>', '<Left>', { silent = true })

vim.keymap.set('n', '<silent>', '<A-j> :MoveLine(1)<CR>', { silent = true })
vim.keymap.set('n', '<silent>', '<A-k> :MoveLine(-1)<CR>', { silent = true })

vim.keymap.set('v', '<silent>', '<A-j> :MoveBlock(1)<CR>', { silent = true })
vim.keymap.set('v', '<silent>', '<A-k> :MoveBlock(-1)<CR>', { silent = true })

--command! So su
--command! W w
--command! Q q
--command! Qa qa
--command! QA qa
--command! WQ wq
--command! Wq wq
--command! MyGdb let g:termdebug_wide = 10 | packadd termdebug | Termdebug

vim.keymap.set('n', '<F7>', ':FloatermToggle<cr>', { silent = true })
--" vim.keymap.set('n', '<F8>', ':silent FloatermSend           tail_latexmk<cr>:FloatermShow<cr>', {silent = true})
--" vim.keymap.set('t', '<F8>', '<c-\><c-n>:silent FloatermSend tail_latexmk<cr>:FloatermShow<cr>', {silent = true})
vim.keymap.set('t', '<F7>', '<c-\\><c-n>:FloatermToggle<cr>', { silent = true })
--let g:floaterm_height=0.8
--let g:floaterm_width=0.8
-- let g:floaterm_wintype="vsplit"

-- audocmd
-- autocmd BufEnter *.txt setlocal spell spelllang=en
--autocmd BufEnter *.tex setlocal spell spelllang=fr

-- Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
vim.keymap.set('n', '<expr>', '<CR> {-> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { silent = true })

-- grep hightlite
vim.keymap.set('n', '<leader>sh', '<cmd>TSHighlightCapturesUnderCursor<CR>', { silent = true })
vim.keymap.set('n', 'q', ':bd<cr>', { silent = true })

vim.keymap.set('n', 'gt', 'viW"dy:tabnew <c-r>d<cr>', { silent = true })
