local opt = vim.opt

vim.g.loaded_matchparen = 1
vim.g.mapleader = ' '
vim.g.markdown_fenced_languages = { 'html', 'python', 'bash', 'sh' }
-- opt.makeprg = './build.sh'
opt.completeopt = { 'menuone' }

-- opt.cursorline = true
opt.shiftround = true
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.path:append('**') -- search down into subfolders
opt.breakindent = true -- visually wrap lines

-- Ignore compiled files
opt.wildignore = '__pycache__'
opt.wildignore:append({ '*.o', '*~', '*.pyc', '*pycache*' })
opt.wildignore:append({ 'Cargo.lock', 'Cargo.Bazel.lock' })

opt.pumblend = 30
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

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.formatoptions = opt.formatoptions
    - 'a' -- Auto formatting is BAD.
    - 't' -- Don't auto format my code. I got linters for that.
    + 'c' -- In general, I like it when comments respect textwidth
    + 'q' -- Allow formatting comments w/ gq
    - 'o' -- O and o, don't continue comments
    - 'r' -- Don't insert comment after <Enter>
    + 'n' -- Indent past the formatlistpat, not underneath it.
    + 'j' -- Auto-remove comments if possible.
    - '2' -- I'm not in gradeschool anymore

opt.wrap = false

local tmp_undo = ''
if os.getenv('TMPDIR') then
    tmp_undo = os.getenv('TMPDIR') .. '/nvim/undodir'
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
opt.smartcase = true -- override ignorecase if search pattern contains upper case characters
opt.smarttab = true
opt.smartindent = true

opt.termguicolors = true
opt.signcolumn = 'yes'
opt.isfname:append('@-@')
opt.updatetime = 300
opt.colorcolumn = '80'

opt.linebreak = true
opt.linespace = 5

opt.wrap = false
opt.autoindent = true
opt.mouse = 'a'

opt.clipboard = 'unnamedplus,unnamed'

opt.inccommand = 'split'
opt.spellsuggest = { 'best', 6 }

-- vim.cmd [[
-- set clipboard+=unnamedplus
-- set clipboard+=unnamed
-- set mouse=a
-- ]]
