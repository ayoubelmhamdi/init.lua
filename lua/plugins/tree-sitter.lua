return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
        { 'lewis6991/spellsitter.nvim' },
        { 'David-Kunz/treesitter-unit' },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'p00f/nvim-ts-rainbow' },
        -- { 'filNaj/tree-setter' },
    },
    build = ':TSUpdate',
    --
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { 'markdown', 'markdown_inline', 'javascript', 'typescript', 'c', 'python', 'lua', 'rust', 'bash', 'cpp', 'dart', 'gitcommit', 'html', 'json', 'latex', 'query', 'vimdoc', 'xml', 'yaml'},

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

        require('nvim-treesitter.install').prefer_git = true
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.typst = {
            install_info = {
                -- url = 'https://github.com/frozolotl/tree-sitter-typst.git',
                url = '/data/local_tmp/github_treesitters/tree-sitter-typst',
                files = { 'src/parser.c', 'src/scanner.c' },
                -- branch = 'main',
            },
            filetype = 'typst', -- if filetype does not agrees with parser name
        }
    end,
}
