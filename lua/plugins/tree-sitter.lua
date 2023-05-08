return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { 'nvim-treesitter/playground' },
    { 'lewis6991/spellsitter.nvim' },
    { 'David-Kunz/treesitter-unit' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'p00f/nvim-ts-rainbow' },
  },
  build = ':TSUpdate',
  --
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'javascript', 'typescript', 'c', 'lua', 'rust' },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    }
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.typst = {
      install_info = {
        url = '/data/github/tree-sitter-typst',
        files = { 'src/parser.c' , 'src/scanner.cc'},
        branch = 'main',
      },
      filetype = 'typst', -- if filetype does not agrees with parser name
    }
  end,
}
