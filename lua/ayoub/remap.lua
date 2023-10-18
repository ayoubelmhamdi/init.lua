vim.g.mapleader = ' '

local key = vim.keymap.set

-- vim.cmd 'nnoremap <buffer> <CR> <CR>:cclose<CR>'

key('n', '<C-Space>', '<cmd>lua require("ayoub.compilation").OpenQuickfix("%<")<CR>')

key('n', '<space><space>', ':TSPlaygroundToggle<cr>', {})
key('n', '-', '<cmd>lua require("oil").open()<cr>', { silent = true })

key({ 'n' }, '<F5>', ':echo synIDattr(synID(line("."), col("."), 1), "name")<CR>', { silent = true })

key({ 'n' }, '<cr>', 'viw', { silent = true })
key({ 'n' }, '<esc>', '<esc>:noh<cr>', { silent = true })

key({ 'n', 'v' }, 'j', 'gj', { silent = true })
key({ 'n', 'v' }, 'k', 'gk', { silent = true })

key('n', '<leader>zn', ':TZNarrow<CR>', { silent = true })
key('v', '<leader>zn', ":'<,'>TZNarrow<CR>", { silent = true })
key('n', '<leader>zf', ':TZFocus<CR>', { silent = true })
key('n', '<leader>zm', ':TZAtaraxis<CR>', { silent = true })
-- k('n', '<leader>zm', ':TZMinimalist<CR>', { silent = true })

key({ 'n', 'v' }, '<A-@>', ':%s#@@@#\\r#g<CR>', { silent = true })

key({ 'n', 'v' }, ',tp', '<cmd>lua  require("ayoub.te_prompt_picker").preview_files()<CR>')

key({ 'n', 'v' }, ',ae', '<cmd>lua require("ayoub.chat").main("client-embedding")<CR>Gzz')
key({ 'n', 'v' }, ',ao', '<cmd>lua require("ayoub.chat").main("GPT3")<CR>Gzz')
key({ 'n', 'v' }, ',am', '<cmd>lua require("ayoub.chat").main("Bing")<CR>Gzz')
key({ 'n', 'v' }, ',ag', '<cmd>lua require("ayoub.chat").main("Bard")<CR>Gzz')

-- key({ 'n', 'v' }, '<A-1>', ':tabnext 1<CR>')
-- key({ 'n', 'v' }, '<A-2>', ':tabnext 2<CR>')
-- key({ 'n', 'v' }, '<A-3>', ':tabnext 3<CR>')
-- key({ 'n', 'v' }, '<A-4>', ':tabnext 4<CR>')
-- key({ 'n', 'v' }, '<A-5>', ':tabnext 5<CR>')
-- key({ 'n', 'v' }, '<A-6>', ':tabnext 6<CR>')
-- key({ 'n', 'v' }, '<A-7>', ':tabnext 7<CR>')
-- key({ 'n', 'v' }, '<A-8>', ':tabnext 8<CR>')
-- key({ 'n', 'v' }, '<A-7>', ':tabnext 9<CR>')

key('v', 'J', ":m '>+1<CR>gv=gv")
key('v', 'K', ":m '<-2<CR>gv=gv")

key('n', 'J', 'mzJ`z')
key({ 'n', 'v' }, '<C-d>', '<C-d>zz')
key({ 'n', 'v' }, '<C-u>', '<C-u>zz')
key({ 'n', 'v' }, 'n', 'nzzzv')
key({ 'n', 'v' }, 'N', 'Nzzzv')

-- k('v', ',y', '"dy')
-- k('n', ',p', '"dp')

-- This is going to get me cancelled
key('i', '<C-c>', '<Esc>')

key('n', 'Q', '<nop>')
key('n', '<leader>f', function()
  vim.lsp.buf.format()
end)

key('n', '<C-k>', '<cmd>cnext<CR>zz')
key('n', '<C-j>', '<cmd>cprev<CR>zz')
key('n', '<leader>k', '<cmd>lnext<CR>zz')
key('n', '<leader>j', '<cmd>lprev<CR>zz')

key('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
key('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- k(
--   'n',
--   '<space><space>',
--   ':w<cr>:silent !python -m jupyter_ascending.requests.sync --filename %&:<cr>',
--   { silent = true }
-- )
key('n', '<c-w>o', ':Zoom<cr>', { silent = true })

key('n', 'x', '"_x', { silent = true })
key('n', 'X', '"_X', { silent = true })
key('n', 'c', '"_c', { silent = true })
key('n', 'C', '"_C', { silent = true })

key('v', 'x', '"_x', { silent = true })
key('v', 'X', '"_X', { silent = true })
key('v', 'c', '"_c', { silent = true })
key('v', 'C', '"_C', { silent = true })

key('v', 'y', 'ygv<Esc>', { silent = true })
key('v', 'Y', 'Ygv<Esc>', { silent = true })

-- k('v', 'p', 'pgvy', { silent = true })
-- k('v', 'P', 'Pgvy', { silent = true })

-- k('n', 'p', 'pgvy', { silent = true })
-- k('n', 'P', 'Pgvy', { silent = true })
--'p', 'pgvy', { silent = true })
-- k('n',
vim.cmd [[xnoremap <silent> p p:let @+=@0<CR>:let @"=@0<CR>]]

key('n', ',or', ':OverseerRun<cr>', { silent = true })
key('n', ',ol', ':OverseerLoadBundle<cr>', { silent = true })
-- k("n", ",ot", ":OverseerTaskAction<cr>", { silent = true })
key('n', ',oq', ':OverseerQuickAction<cr>', { silent = true })
key('n', ',ov', ':OverseerQuickAction open vsplit<cr>', { silent = true })
key('n', ',ow', ':OverseerQuickAction watch<cr>', { silent = true })

key('n', 'q:', ':q', { silent = true })

key('n', '<Space>fs', ':Telescope current_buffer_fuzzy_find<cr>', { silent = true })
key('n', '<Space>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { silent = true })
key('n', '<Space>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { silent = true })
key('n', '<Space>hh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', { silent = true })
key(
  'n',
  '<Space>ff',
  '<cmd>lua require("telescope.builtin").find_files({ find_command = { "fd","-tf","-tl"}})<cr>',
  { silent = true }
)

key('n', '<Space>f.', ':lua require("tsp.cwd-tsp").search_dotfiles()<cr> ', { silent = true })
key('n', '<Space>f-', ':lua require("tsp.cwd-tsp").search_nvim()<cr> ', { silent = true })
key('n', '<Space>fw', ':lua require("tsp.cwd-tsp").search_wiki()<cr> ', { silent = true })
key('n', '<Space>f1', ':lua require("tsp.cwd-tsp").search_proj("sl")<cr> ', { silent = true })
key('n', '<Space>f2', ':lua require("tsp.cwd-tsp").search_proj("slstatus")<cr> ', { silent = true })

--key('n', '<Tab>', ':tabnext<cr>', { silent = true })
--key('n', '<S-Tab>', ':tabprev<cr>', { silent = true })

key('i', '<c-a-k>', '<c-k>', { silent = true })

key('n', '<up>', 'k<c-y>', { silent = true })
key('n', '<down>', 'j<c-e>', { silent = true })

key('t', '<esc><esc>', '<c-\\><c-n><esc>', { silent = true })
key('t', '<Tab>', '<c-\\><c-n>:tabnext<cr>', { silent = true })
key('t', '<S-Tab>', '<c-\\><c-n>:tabprev<cr>', { silent = true })

key('n', '<C-Up>', ':resize +2<cr>', { silent = true })
key('n', '<C-Down>', ':resize -2<cr>', { silent = true })
key('n', '<C-Left>', '10h', { silent = true })
key('n', '<C-Right>', '10l', { silent = true })
-- key('n', '<C-Left>', ':vertical resize -2<cr>', { silent = true })
-- key('n', '<C-Right>', ':vertical resize +2<cr>', { silent = true })

key('t', '<C-Up>', '<C-\\><C-N>:resize +2<cr>', { silent = true })
key('t', '<C-Down>', '<C-\\><C-N>:resize -2<cr>', { silent = true })
key('t', '<C-Left>', '<C-\\><C-N>:vertical resize -2<cr>', { silent = true })
key('t', '<C-Right>', '<C-\\><C-N>:vertical resize +2<cr>', { silent = true })

--Basic file system commands
key('n', '<C-M-o>', ':!touch<Space>', { silent = true })
key('n', '<C-M-d>', ':!mkdir<Space>', { silent = true })
key('n', '<C-M-c>', ':!cp<Space>%<Space>', { silent = true })
key('n', '<C-M-m>', ':!mv<Space>%<Space>', { silent = true })

-- fix p y
--k('n', 's', '<NOP>', {silent = true})
--k('n', 'S', '<NOP>', {silent = true})
key('n', '<C-Q>', ':noautocmd bd<cr>', { silent = true })
key('n', '<C-Q><C-Q>', ':noautocmd q<cr>', { silent = true })
key('n', '<Space>w', ':w<cr>', { silent = true })

key('n', '>', 'v>', { silent = true })
key('n', '<', 'v<', { silent = true })
key('v', '>', '>gv', { silent = true })
key('v', '<', '<gv', { silent = true })

key('i', '<A-a>', '<Right>', { silent = true })
key('i', '<A-i>', '<Left>', { silent = true })

key('n', '<silent>', '<A-j>:MoveLine(1)<CR>', { silent = true })
key('n', '<silent>', '<A-k>:MoveLine(-1)<CR>', { silent = true })

key('v', '<silent>', '<A-j>:MoveBlock(1)<CR>', { silent = true })
key('v', '<silent>', '<A-k>:MoveBlock(-1)<CR>', { silent = true })

--command! So su
--command! W w
--command! Q q
--command! Qa qa
--command! QA qa
--command! WQ wq
--command! Wq wq
--command! MyGdb let g:termdebug_wide = 10 | packadd termdebug | Termdebug

key('n', '<F7>', ':FloatermToggle<cr>', { silent = true })
--" k('n', '<F8>', ':silent FloatermSend           tail_latexmk<cr>:FloatermShow<cr>', {silent = true})
--" k('t', '<F8>', '<c-\><c-n>:silent FloatermSend tail_latexmk<cr>:FloatermShow<cr>', {silent = true})
key('t', '<F7>', '<c-\\><c-n>:FloatermToggle<cr>', { silent = true })
--let g:floaterm_height=0.8
--let g:floaterm_width=0.8
-- let g:floaterm_wintype="vsplit"

-- audocmd
-- autocmd BufEnter *.txt setlocal spell spelllang=en
--autocmd BufEnter *.tex setlocal spell spelllang=fr

-- Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
key('n', '<expr>', '<CR> {-> v:hlsearch ? ":nohl\\<CR>":"\\<CR>"}()', { silent = true })

-- grep hightlite
key('n', '<leader>sh', '<cmd>TSHighlightCapturesUnderCursor<CR>', { silent = true })
key('n', 'q', ':bd<cr>', { silent = true })

key('n', 'gt', 'viW"dy:tabnew <c-r>d<cr>', { silent = true })

-- need zz in the last moving
-- k({ 'n', 'v' }, '<C-U>', '<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>', { silent = true })
-- k({ 'n', 'v' }, '<C-D>', '<C-E><C-E><C-E><C-E><C-E><C-E>', { silent = true })
