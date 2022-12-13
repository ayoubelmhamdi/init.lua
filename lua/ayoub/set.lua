vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true


vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/local/share/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.g.mapleader = " "


vim.cmd [[

set spellsuggest+=5
set linebreak
set linespace=5
set clipboard+=unnamedplus
set clipboard+=unnamed
set inccommand=split


set nowrap
set autoindent
set mouse=a
]]
