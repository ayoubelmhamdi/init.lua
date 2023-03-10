return {
  { 'nvim-lua/plenary.nvim' },

  -- Git
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'airblade/vim-rooter' },
  -- Basic
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {}
    end,
  },
  { 'static-nvim/mkdir' },
  { 'fedepujol/move.nvim' },
  { 'oberblastmeister/zoom.nvim' },
  { 'stevearc/overseer.nvim' },
  -- Test
  { 'folke/zen-mode.nvim' },
  { 'github/copilot.vim' },
  { 'yazgoo/vmux' },
  { 'nyngwang/suave.lua' },
  -- Localy
  -- { '/data/projects/lua/gg.nvim' },
}