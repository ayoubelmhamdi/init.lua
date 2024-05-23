local REQ = require('ayoub.mini_functions').REQ

local configs = REQ('nvim-treesitter.configs')
if not (configs) then return end

configs.setup({
    ensure_installed = { 'markdown', 'markdown_inline', 'javascript', 'typescript', 'c', 'python', 'lua', 'rust', 'bash', 'cpp', 'dart', 'gitcommit', 'html', 'json', 'latex', 'query', 'vimdoc', 'xml', 'yaml' },

    sync_install = false,
    auto_install = true,
    -- 'filNaj/tree-setter'
    -- tree_setter = {
    --   enable = true,
    -- },

    highlight = {
        enable = true,
        -- disable = { 'markdown' },
        additional_vim_regex_highlighting = true,
        -- disable = function(lang, buf)
        --   local max_filesize = 100 * 1024 -- 100 KB
        --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --   if ok and stats and stats.size > max_filesize then
        --     return true
        --   end
        -- end,
    },
})

-- local parsers = REQ('nvim-treesitter.parsers')
-- local install = REQ('nvim-treesitter.install')
-- if not (parsers and install) then return end

-- install.prefer_git = true
-- local parser_config = parsers.get_parser_configs()
-- parser_config.typst = {
--     install_info = {
--         -- url = 'https://github.com/frozolotl/tree-sitter-typst.git',
--         url = '/data/local_tmp/github_treesitters/tree-sitter-typst',
--         files = { 'src/parser.c', 'src/scanner.c' },
--         -- branch = 'main',
--     },
--     filetype = 'typst', -- if filetype does not agrees with parser name
-- }
