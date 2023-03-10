return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'barreiroleo/ltex-extra.nvim' },
      { 'hrsh7th/nvim-cmp' },
    },
    config = function()
      local on_attach = require('ayoub.lsp').on_attach
      local handlers = require('ayoub.lsp').handlers
      local capabilities = require('ayoub.lsp').capabilities
      local toggleLsp = require('ayoub.lsp').toggleLsp
      local mylspconfig = require('ayoub.lsp').mylspconfig

      local lspconfig = require 'lspconfig'
      -- lspconfig.grammarly.setup {
      --   handlers = handlers,
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   init_options = { clientId = 'client_BaDkMgx4X19X9UxxYRCXZo' },
      -- }


     lspconfig.pyright.setup{
        handlers = handlers,
        capabilities = capabilities,
        on_attach = on_attach,
     }
      -- clangd server setup
      local clangd_capabilities = capabilities
      clangd_capabilities.offsetEncoding = 'utf-8'

      lspconfig.clangd.setup {
        handlers = handlers,
        capabilities = clangd_capabilities,
        on_attach = on_attach,
        single_file_support = true,
        filetype = { 'c', 'cpp' },
      }

      -- lspconfig.ltex.setup { cmd = { '/home/mhamdi/.cache/ltex-ls-15.2.0/bin/ltex-ls' } }
      -- ltex: open source Grammar
      -- s.getenv("HOME")
      local lang = os.getenv 'PROJECT_LANG' or 'en'
      lspconfig.ltex.setup {
        handlers = handlers,
        -- capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- your other on_attach functions.
          on_attach(client, bufnr)
          require('ltex_extra').setup {
            -- load_langs = { 'fr' }, -- table <string> : languages for witch dictionaries will be loaded
            init_check = true, -- boolean : whether to load dictionaries on startup
            path = nil, -- string : path to store dictionaries. Relative path uses current working directory
            log_level = 'none', -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
          }
        end,
        settings = {
          ltex = {
            language = lang,
            diagnosticSeverity = 'information',
            setenceCacheSize = 2000,
            additionalRules = {
              enablePickyRules = true,
              motherTongue = 'en',
            },
            trace = { server = 'verbose' },
            dictionary = {},
            disabledRules = {
              -- ['en'] = { 'MORFOLOGIK_RULE_EN' },
              -- ['en-GB'] = { 'MORFOLOGIK_RULE_EN_GB' },
              -- ['en-US'] = { 'MORFOLOGIK_RULE_EN_US' },
              -- ['it'] = { 'MORFOLOGIK_RULE_IT_IT' },
            },
            hiddenFalsePositives = {},
            -- languageToolHttpServerUri = 'http://localhost:8081/v2',
          },
        },
      }

      lspconfig.lua_ls.setup {
        handlers = handlers,
        capabilities = capabilities,
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              checkThirdParty = false, -- FIX the sumneko need config
              -- Make the server await for loading Neovim runtime files
              maxPreload = 1000,
              preloadFileSize = 500,
            },
          },
        },
      }
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = 'dart',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local on_attach = require('ayoub.lsp').on_attach
      local handlers = require('ayoub.lsp').handlers
      local capabilities = require('ayoub.lsp').capabilities
      local toggleLsp = require('ayoub.lsp').toggleLsp
      local mylspconfig = require('ayoub.lsp').mylspconfig

      require('flutter-tools').setup {
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        -- flutter_lookup_cmd = "dirname $(which flutter)",
        widget_guides = {
          enabled = true,
        },
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities,
          handlers = handlers,
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
          },
        },
      }
      require('telescope').load_extension 'flutter'
    end,
  },
}
