require('ayoub.set')
require('ayoub.remap')
require('ayoub.autocmd')
require('ayoub.lazy')

vim.g.asmsyntax = 'nasm'
-- Disable Default Vim Plugins
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
--vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_spec = 0
vim.g.loaded_syncolor = 0

local ok, rg_module = pcall(require, 'ayoub.rg')
if not ok then
  vim.api.nvim_err_writeln("Failed to load the Rg module")
  return
end

vim.api.nvim_create_user_command('Rg', function(opts) rg_module.main(false, opts.args) end, { nargs = '?', desc = 'Search using Rg (ripgrep)' })
vim.api.nvim_create_user_command('Rge', function(opts) rg_module.main(true, opts.args) end, { nargs = '?', desc = 'Search using Rg (ripgrep)' })
