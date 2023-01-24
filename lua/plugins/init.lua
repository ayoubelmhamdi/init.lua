return {
  { 'nvim-lua/plenary.nvim' },

  { 'glepnir/lspsaga.nvim' },
  -- Theme
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'sainnhe/gruvbox-material' },
  -- LSP Support
  { 'neovim/nvim-lspconfig' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'akinsho/flutter-tools.nvim' },
  --{'barreiroleo/ltex-extra.nvim'},
  -- Dap
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'leoluz/nvim-dap-go' },

  -- Autocompletion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'hrsh7th/cmp-cmdline' },
  { 'lukas-reineke/cmp-rg' },
  { 'mstanciu552/cmp-matlab' },

  -- Snippets
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },

  -- telescope
  { 'nvim-telescope/telescope.nvim', version = '0.1.0' },
  { 'nvim-telescope/telescope-fzf-native.nvim' },
  { 'theprimeagen/harpoon' },

  -- TS
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/playground' },
  { 'lewis6991/spellsitter.nvim' },
  { 'David-Kunz/treesitter-unit' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'p00f/nvim-ts-rainbow' },

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
