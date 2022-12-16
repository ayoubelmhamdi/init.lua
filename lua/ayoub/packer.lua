-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }
  use { 'nvim-lua/plenary.nvim' }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- Theme
      { 'lukas-reineke/indent-blankline.nvim' },
      { 'rose-pine/neovim', as = 'rose-pine' },
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
      { 'nvim-telescope/telescope.nvim', tag = '0.1.0' },
      { 'nvim-telescope/telescope-fzf-native.nvim' },
      { 'theprimeagen/harpoon' },

      -- TS
      { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
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
      { 'numToStr/Comment.nvim' },
      { 'static-nvim/mkdir' },
      { 'fedepujol/move.nvim' },
      { 'oberblastmeister/zoom.nvim' },
      { 'stevearc/overseer.nvim' },
      -- Test
      { 'folke/zen-mode.nvim' },
      { 'github/copilot.vim' },
      { 'https://github.com/yazgoo/vmux' },
      -- Localy
      { '/data/projects/lua/gg.nvim' },
    },
  }
end)
