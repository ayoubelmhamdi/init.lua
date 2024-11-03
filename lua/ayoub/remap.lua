vim.g.mapleader = ' '

local key = vim.keymap.set
local opt = { noremap = true, silent = true }
local control = require('ayoub.control')

key("i", "<C-E>", "<C-Y>", opt)
key("i", "<C-Y>", "<C-E>", opt)

key("n", ">", ">>", opt)
key("n", "<", "<<", opt)

key("v", ">", ">gv", opt)
key("v", "<", "<gv", opt)

key("n", "<c-j>", "<C-W><C-J>", opt)
key("n", "<c-k>", "<C-W><C-K>", opt)
key("n", "<c-l>", "<C-W><C-L>", opt)
key("n", "<c-h>", "<C-W><C-H>", opt)


key('n', '<A-c>', function() control.chat('diff') end, opt)
key('n', '<C-f>', function() control.toggle('format') end, opt)
key('n', '<C-s>', function() control.toggle('check') end, opt)
key('v', '<C-f>', function() control.toggle('cmd')end, opt)

key('n', '<space>r', '<cmd>lua R("vmath")<cr>', opt)
key('n', '<space>m', '<cmd>lua R("vmath")<cr>:lua require("vmath").print_function_info()<cr>', opt)

-- key('n', '<space>b', function() require('qbuf').copen_and_cnext() end, opt)

-- key('n', '<C-Space>',' <cmd>lua require("ayoub.compilation").OpenQuickfix("make | redraw! |echo \\"make finished\\"")<CR>', {})
key('i', '<TAB>', '<C-I>')
key({ 'i', 'n' }, '<A-d>', ':t.<CR>', opt)
-- key('i', '<C-L>', '<C-X><C-L>', opt)
-- key('i', '<C-I>', '<C-X><C-I>', opt)
-- key('i', '<C-]>', '<C-X><C-]>', opt)
-- key('i', '<C-F>', '<C-X><C-F>', opt)
-- key('i', '<C-D>', '<C-X><C-D>', opt)

-- key('n', '<C-Space>', ':new | term ./dwm<CR>', {})

key('n', '<space><space>', ':TSPlaygroundToggle<cr>', opt)
key('n', '-', '<cmd>lua require("oil").open()<cr>', opt)

key({ 'n' }, '<F5>', ':echo synIDattr(synID(line("."), col("."), 1), "name")<CR>', opt)

key({ 'n' }, '<esc>', '<esc>:noh<cr>', opt)

key({ 'n', 'v' }, 'j', 'gj', opt)
key({ 'n', 'v' }, 'k', 'gk', opt)

key('n', '<leader>zn', ':TZNarrow<CR>', opt)
key('v', '<leader>zn', ":'<,'>TZNarrow<CR>", opt)
key('n', '<leader>zf', ':TZFocus<CR>', opt)
key('n', '<leader>zm', ':TZAtaraxis<CR>', opt)
-- k('n', '<leader>zm', ':TZMinimalist<CR>', opt)

key({ 'n', 'v' }, '<A-@>', ':%s#@@@#\\r#g<CR>', opt)

key({ 'n', 'v' }, ',tp', '<cmd>lua  require("ayoub.te_prompt_picker").preview_files()<CR>', opt)

key({ 'n', 'v' }, ',ae', '<cmd>lua require("ayoub.chat").main("client-embedding")<CR>Gzz', opt)
key({ 'n', 'v' }, ',ao', '<cmd>lua require("ayoub.chat").main("GPT3")<CR>Gzz', opt)
key({ 'n', 'v' }, ',am', '<cmd>lua require("ayoub.chat").main("Bing")<CR>Gzz', opt)
key({ 'n', 'v' }, ',ag', '<cmd>lua require("ayoub.chat").main("Bard")<CR>Gzz', opt)

-- key({ 'n', 'v' }, '<A-1>', ':tabnext 1<CR>', opt)
-- key({ 'n', 'v' }, '<A-2>', ':tabnext 2<CR>', opt)
-- key({ 'n', 'v' }, '<A-3>', ':tabnext 3<CR>', opt)
-- key({ 'n', 'v' }, '<A-4>', ':tabnext 4<CR>', opt)
-- key({ 'n', 'v' }, '<A-5>', ':tabnext 5<CR>', opt)
-- key({ 'n', 'v' }, '<A-6>', ':tabnext 6<CR>', opt)
-- key({ 'n', 'v' }, '<A-7>', ':tabnext 7<CR>', opt)
-- key({ 'n', 'v' }, '<A-8>', ':tabnext 8<CR>', opt)
-- key({ 'n', 'v' }, '<A-7>', ':tabnext 9<CR>', opt)

key('v', 'J', ":m '>+1<CR>gv=gv", opt)
key('v', 'K', ":m '<-2<CR>gv=gv", opt)

key('n', 'J', 'mzJ`z', opt)
key({ 'n', 'v' }, '<C-d>', '<C-d>zz', opt)
key({ 'n', 'v' }, '<C-u>', '<C-u>zz', opt)
key({ 'n', 'v' }, 'n', 'nzzzv', opt)
key({ 'n', 'v' }, 'N', 'Nzzzv', opt)

-- k('n', ',p', '"dp', opt)
-- k('v', ',y', '"dy', opt)

-- This is going to get me cancelled
key('i', '<C-c>', '<Esc>', opt)

key('n', 'Q', '<nop>', opt)

key('n', '<leader>k', '<cmd>lnext<CR>zz', opt)
key('n', '<leader>j', '<cmd>lprev<CR>zz', opt)

key('n', '<A-s>', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', opt)
key('n', '<leader>x', '<cmd>!chmod +x %<CR>', opt)

-- k(
--   'n',
--   '<space><space>',
--   ':w<cr>:silent !python -m jupyter_ascending.requests.sync --filename %&:<cr>',
--   opt
-- )
-- key('n', '<c-w>o', ':Zoom<cr>', opt)

key('n', 'x', '"_x', opt)
key('n', 'X', '"_X', opt)
key('n', 'c', '"_c', opt)
key('n', 'C', '"_C', opt)

key('v', 'x', '"_x', opt)
key('v', 'X', '"_X', opt)
key('v', 'c', '"_c', opt)
key('v', 'C', '"_C', opt)

key('v', 'y', 'ygv<Esc>', opt)
key('v', 'Y', 'Ygv<Esc>', opt)

-- k('v', 'p', 'pgvy', opt)
-- k('v', 'P', 'Pgvy', opt)

-- k('n', 'p', 'pgvy', opt)
-- k('n', 'P', 'Pgvy', opt)
--'p', 'pgvy', opt)
-- k('n',
vim.cmd([[xnoremap <silent> p p:let @+=@0<CR>:let @"=@0<CR>]])

key('n', ',or', ':OverseerRun<cr>', opt)
key('n', ',ol', ':OverseerLoadBundle<cr>', opt)
-- k("n", ",ot", ":OverseerTaskAction<cr>", opt)
key('n', ',oq', ':OverseerQuickAction<cr>', opt)
key('n', ',ov', ':OverseerQuickAction open vsplit<cr>', opt)
key('n', ',ow', ':OverseerQuickAction watch<cr>', opt)

key('n', 'q:', ':q', opt)

key('n', '<Space>fs', ':Telescope current_buffer_fuzzy_find<cr>', opt)
key('n', '<Space>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opt)
key('n', '<Space>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opt)
key('n', '<Space>hh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opt)
key('n', '<Space>ff', '<cmd>lua require("telescope.builtin").find_files({ find_command = { "fd","-tf","-tl"}})<cr>', opt)

key('n', '<Space>f.', ':lua require("tsp.cwd-tsp").search_dotfiles()<cr> ', opt)
key('n', '<Space>f-', ':lua require("tsp.cwd-tsp").search_nvim()<cr> ', opt)
key('n', '<Space>fw', ':lua require("tsp.cwd-tsp").search_wiki()<cr> ', opt)
key('n', '<Space>f1', ':lua require("tsp.cwd-tsp").search_proj("sl")<cr> ', opt)
key('n', '<Space>f2', ':lua require("tsp.cwd-tsp").search_proj("slstatus")<cr> ', opt)

key('n', '<Tab>', ':bn<cr>', opt)
--key('n', '<S-Tab>', ':tabprev<cr>', opt)

key('i', '<c-a-k>', '<c-k>', opt)

key('n', '<up>', 'k<c-y>', opt)
key('n', '<down>', 'j<c-e>', opt)

key('t', '<esc><esc>', '<c-\\><c-n><esc>', opt)
key('t', '<Tab>', '<c-\\><c-n>:bn<cr>', opt)

key('n', '<C-Up>', ':resize +2<cr>', opt)
key('n', '<C-Down>', ':resize -2<cr>', opt)
key('n', '<C-Left>', '10h', opt)
key('n', '<C-Right>', '10l', opt)
-- key('n', '<C-Left>', ':vertical resize -2<cr>', opt)
-- key('n', '<C-Right>', ':vertical resize +2<cr>', opt)

key('t', '<C-Up>', '<C-\\><C-N>:resize +2<cr>', opt)
key('t', '<C-Down>', '<C-\\><C-N>:resize -2<cr>', opt)
key('t', '<C-Left>', '<C-\\><C-N>:vertical resize -2<cr>', opt)
key('t', '<C-Right>', '<C-\\><C-N>:vertical resize +2<cr>', opt)

--Basic file system commands
-- key('n', '<C-M-o>', ':!touch<Space>', opt)
-- key('n', '<C-M-d>', ':!mkdir<Space>', opt)
-- key('n', '<C-M-c>', ':!cp<Space>%<Space>', opt)
-- key('n', '<C-M-m>', ':!mv<Space>%<Space>', opt)

-- fix p y
--k('n', 's', '<NOP>', {silent = true})
--k('n', 'S', '<NOP>', {silent = true})
-- key('n', '<C-Q>', ':noautocmd bd<cr>', opt)
key('n', '<C-Q><C-Q>', ':noautocmd q<cr>', opt)
key('n', '<Space>w', ':w<cr>', opt)


key('i', '<A-a>', '<Right>', opt)
key('i', '<A-i>', '<Left>', opt)

key('n', '<silent>', '<A-j>:MoveLine(1)<CR>', opt)
key('n', '<silent>', '<A-k>:MoveLine(-1)<CR>', opt)

key('v', '<silent>', '<A-j>:MoveBlock(1)<CR>', opt)
key('v', '<silent>', '<A-k>:MoveBlock(-1)<CR>', opt)

--command! So su
vim.cmd([[
command! W w
command! Q q

command! Qa qa
command! QA qa

command! Wq wq
command! WQ wq

command! Wqa wqa
command! WQa wqa
command! WQA wqa
]])
--command! MyGdb let g:termdebug_wide = 10 | packadd termdebug | Termdebug

key('n', '<F7>', ':FloatermToggle<cr>', opt)
--" k('n', '<F8>', ':silent FloatermSend           tail_latexmk<cr>:FloatermShow<cr>', {silent = true})
--" k('t', '<F8>', '<c-\><c-n>:silent FloatermSend tail_latexmk<cr>:FloatermShow<cr>', {silent = true})
key('t', '<F7>', '<c-\\><c-n>:FloatermToggle<cr>', opt)
--let g:floaterm_height=0.8
--let g:floaterm_width=0.8
-- let g:floaterm_wintype="vsplit"

-- audocmd
-- autocmd BufEnter *.txt setlocal spell spelllang=en
--autocmd BufEnter *.tex setlocal spell spelllang=fr

-- Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
key('n', '<expr>', '<CR> {-> v:hlsearch ? ":nohl\\<CR>":"\\<CR>"}()', opt)

-- grep hightlite
key('n', '<leader>sh', '<cmd>TSHighlightCapturesUnderCursor<CR>', opt)
key('n', '<C-q><C-q>', ':bd<cr>', opt)

key('n', 'gt', 'viW"dy:tabnew <c-r>d<cr>', opt)

key('n', '<C-J>', function()
    local keys = {}
    local qflist = vim.fn.getqflist()

    if not vim.tbl_isempty(qflist) then
        return '<cmd>silent! cnext<CR>'
    else
        return '<C-W><C-J>'
    end
end, { expr = true })
key('n', '<C-K>', function()
    local keys = {}
    local qflist = vim.fn.getqflist()

    if not vim.tbl_isempty(qflist) then
        return '<cmd>silent! cprev<CR>'
    else
        return '<C-W><C-K>'
    end
end, { expr = true })



key('n', '<CR>', function()
    local qflist = false
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then qflist = true end
    end

    local enter = 'viw'
    if qflist then enter = ':cclose<CR>viw' end
    if vim.opt.hlsearch:get() then vim.cmd.nohl() end

    return enter
end, { expr = true })

