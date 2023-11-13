local opt = vim.opt

vim.g.loaded_matchparen = 1
vim.g.mapleader = ' '
vim.g.markdown_fenced_languages = { 'html', 'python', 'bash', 'sh' }
opt.makeprg = './build.sh'
opt.completeopt = { 'menuone' }

opt.cursorline = true

-- Ignore compiled files
opt.wildignore = '__pycache__'
opt.wildignore:append { '*.o', '*~', '*.pyc', '*pycache*' }
opt.wildignore:append { 'Cargo.lock', 'Cargo.Bazel.lock' }

opt.pumblend = 7
opt.wildmode = 'longest:full'
opt.wildoptions = 'pum'

opt.equalalways = false -- I don't like my windows changing all the time
opt.shada = { '!', "'1000", '<50', 's10', 'h' }
opt.joinspaces = false
opt.fillchars = { eob = '~' }
-- tj end

opt.laststatus = 0

opt.hidden = true
opt.splitbelow = true
opt.splitright = true

opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

local tmp_undo = ''
if os.getenv 'TMPDIR' then
  tmp_undo = os.getenv 'TMPDIR' .. '/nvim/undodir'
else
  tmp_undo = '/tmp/nvim/undodir'
end
opt.swapfile = false
opt.backup = false
opt.undodir = tmp_undo -- try to use TMPDIR for termux also
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true
opt.showmatch = true
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = 'yes'
opt.isfname:append '@-@'
opt.updatetime = 300
opt.colorcolumn = '80'

opt.linebreak = true
opt.linespace = 5

opt.wrap = false
opt.autoindent = true
opt.mouse = 'a'

opt.clipboard = 'unnamedplus'
opt.clipboard:append { 'unnamed' }

opt.inccommand = 'split'
opt.spellsuggest = { 'best', 6 }

-- vim.cmd [[
-- set clipboard+=unnamedplus
-- set clipboard+=unnamed
-- set mouse=a
-- ]]
