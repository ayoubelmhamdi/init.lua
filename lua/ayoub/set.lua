local opt = vim.opt

vim.g.loaded_matchparen = 1
vim.g.mapleader = ' '
vim.g.markdown_fenced_languages = { 'html', 'python', 'bash', 'sh' }

vim.g.markdown_fenced_languages = {
    'fs=fsharp',
    'js=javascript',
    'py=python',
    'rs=rust',
    'rb=ruby',
    'yex=yex',
    'scala=scala',
    'viml=vim',
    'jsx=javascript',
    'shell=bash',
    'sh',
    'bash',
    'c',
    'rust',
}
-- opt.makeprg = './build.sh'
opt.completeopt = { 'menuone' }
vim.opt.scrolloff = 1

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

opt.cmdheight = 1
opt.laststatus = 3
-- opt.signcolumn = 'no'
-- set foldlevel=0 see after/plugin/vim.vim
-- set foldcolumn=1

opt.hidden = true
opt.splitbelow = true
opt.splitright = true

-- opt.nu = true
-- opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- vim.cmd'set formatoptions-=jcro'
-- vim.cmd'setlocal formatoptions-=cro'
-- opt.formatoptions = opt.formatoptions
--     -- prevent automatically continuing comments
--     - 'c'
--     - 'r'
--     - 'o'
--     --
--     - 'a' -- Auto formatting is BAD.
--     - 't' -- Don't auto format my code. I got linters for that.
--     + 'q' -- Allow formatting comments w/ gq
--     + 'j' -- Auto-remove comments if possible.
--
--     + 'n' -- Indent past the formatlistpat, not underneath it.
--     - '2' -- I'm not in gradeschool anymore

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
opt.isfname:append('@-@')
opt.updatetime = 300
-- opt.colorcolumn = '120'

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
