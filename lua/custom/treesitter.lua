local REQ = require('ayoub.mini_functions').REQ

local config = REQ('nvim-treesitter')
if not (config) then return end

pcall(vim.treesitter.start)

config.setup({
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
        -- additional_vim_regex_highlighting = false,
        -- disable = function(lang, buf)
        --   local max_filesize = 100 * 1024 -- 100 KB
        --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --   if ok and stats and stats.size > max_filesize then
        --     return true
        --   end
        -- end,
    },
})

--2-- local parsers = REQ('nvim-treesitter.parsers')
--2-- local install = REQ('nvim-treesitter.install')
--2-- if not (parsers and install) then return end
--2
--2-- install.prefer_git = true
--2-- local parser_config = parsers.get_parser_configs()
--2-- parser_config.typst = {
--2--     install_info = {
--2--         -- url = 'https://github.com/frozolotl/tree-sitter-typst.git',
--2--         url = '/data/local_tmp/github_treesitters/tree-sitter-typst',
--2--         files = { 'src/parser.c', 'src/scanner.c' },
--2--         -- branch = 'main',
--2--     },
--2--     filetype = 'typst', -- if filetype does not agrees with parser name
--2-- }
--2
--2
--2--1 local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
--2--1 parser_config.jai = {
--2--1   install_info = {
--2--1     url = "https://github.com/constantitus/tree-sitter-jai",
--2--1     files = { "src/parser.c", "src/scanner.c" },
--2--1     revision = "c61176d276761e6ee44a86b018446a1608b47b99",
--2--1   },
--2--1   filetype = "jai",
--2--1 }
--2
--2
