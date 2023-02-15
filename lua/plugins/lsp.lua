local on_attach = require('ayoub.lsp').on_attach
local handlers = require('ayoub.lsp').handlers
local capabilities = require('ayoub.lsp').capabilities
local toggleLsp = require('ayoub.lsp').toggleLsp
local mylspconfig = require('ayoub.lsp').mylspconfig

--1 local handlers = {
--1
--1   ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--1     underline = true,
--1     update_in_insert = false,
--1     virtual_text = true,
--1   }),
--1   ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
--1   ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
--1 }
--1
--1 local on_attach = function(client, bufnr)
--1   -- plugins
--1   -- keymapping
--1   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--1
--1   local bufopts = { noremap = true, silent = true, buffer = bufnr }
--1   vim.keymap.set('n', '<space>tl', toggleLsp, bufopts)
--1   vim.keymap.set('n', ',lR', require('telescope.builtin').lsp_definitions, bufopts)
--1   vim.keymap.set('n', ',lr', require('telescope.builtin').lsp_references, bufopts)
--1   vim.keymap.set('n', ',ly', require('telescope.builtin').lsp_document_symbols, bufopts)
--1   vim.keymap.set('n', ',lY', require('telescope.builtin').lsp_workspace_symbols, bufopts)
--1   vim.keymap.set('n', ',ld', require('telescope.builtin').diagnostics, bufopts)
--1   vim.keymap.set('n', ',tc', require('telescope.builtin').commands, bufopts)
--1   vim.keymap.set('n', ',th', require('telescope.builtin').help_tags, bufopts)
--1   -- Mappings.
--1   -- See `:help vim.lsp.*` for documentation on any of the below functions
--1   -- overwrite by lspsaga
--1   -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--1   -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--1   -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--1   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--1   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--1   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--1   -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--1   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--1   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--1   vim.keymap.set('n', '<space>wl', function()
--1     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--1   end, bufopts)
--1   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--1   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--1   vim.keymap.set('n', '<space>f', function()
--1     vim.lsp.buf.format { async = true }
--1   end, bufopts)
--1 end
--1
--1 local capabilities = require('cmp_nvim_lsp').default_capabilities()
--1 -- local capabilities = vim.lsp.protocol.make_client_capabilities()
--1 -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--1 -- capabilities.textDocument.completion.completionItem.snippetSupport = true
--1 -- capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
--1
--1 vim.g.isLspStart = true
--1 local toggleLsp = function()
--1   if vim.g.isLspStart then
--1     vim.cmd 'LspStop'
--1     vim.g.isLspStart = false
--1   else
--1     vim.cmd 'LspStart'
--1     vim.g.isLspStart = true
--1   end
--1   require('null-ls').toggle {}
--1 end
--1
--1 function mylspconfig()
--1   require('mason').setup {
--1     ui = {
--1       icons = {
--1         package_installed = '✓',
--1         package_pending = '➜',
--1         package_uninstalled = '✗',
--1       },
--1     },
--1   }
--1
--1   local signs = {
--1     {
--1       name = 'DiagnosticSignError',
--1       text = '',
--1       texthl = DiagnosticError,
--1       linehl = {},
--1       numhl = DiagnosticLineNrError,
--1     },
--1     {
--1       name = 'DiagnosticSignWarn',
--1       text = 'כֿ',
--1       texthl = DiagnosticWarn,
--1       linehl = {},
--1       numhl = DiagnosticLineNrWarn,
--1     },
--1     {
--1       name = 'DiagnosticSignHint',
--1       text = '',
--1       texthl = DiagnosticInfo,
--1       linehl = {},
--1       numhl = DiagnosticLineNrInfo,
--1     },
--1     {
--1       name = 'DiagnosticSignInfo',
--1       text = '',
--1       texthl = DiagnosticHint,
--1       linehl = {},
--1       numhl = DiagnosticLineNrHint,
--1     },
--1   }
--1   for _, sign in ipairs(signs) do
--1     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
--1   end
--1
--1   vim.diagnostic.config {
--1     virtual_text = true,
--1     signs = true,
--1     update_in_insert = false,
--1     underline = true,
--1     severity_sort = false,
--1     float = true,
--1   }
--1   -- if true then return end
--1
--1   local opts = { noremap = true, silent = true }
--1   vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
--1   vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
--1   -- -- overwrite by lspsaga
--1   -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
--1   -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'barreiroleo/ltex-extra.nvim' },
    },
    config = function()
      local lspconfig = require 'lspconfig'
      -- lspconfig.grammarly.setup {
      --   handlers = handlers,
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   init_options = { clientId = 'client_BaDkMgx4X19X9UxxYRCXZo' },
      -- }

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
