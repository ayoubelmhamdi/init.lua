require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

local signs = {
  { name = 'DiagnosticSignError', text = '', texthl = DiagnosticError, linehl = {}, numhl = DiagnosticLineNrError },
  { name = 'DiagnosticSignWarn', text = 'כֿ', texthl = DiagnosticWarn, linehl = {}, numhl = DiagnosticLineNrWarn },
  { name = 'DiagnosticSignHint', text = '', texthl = DiagnosticInfo, linehl = {}, numhl = DiagnosticLineNrInfo },
  { name = 'DiagnosticSignInfo', text = '', texthl = DiagnosticHint, linehl = {}, numhl = DiagnosticLineNrHint },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
}
-- if true then return end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- -- overwrite by lspsaga
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

local handlers = {

  ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = true,
  }),
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

vim.g.isLspStart = true
local toggleLsp = function()
  if vim.g.isLspStart then
    vim.cmd 'LspStop'
    vim.g.isLspStart = false
  else
    vim.cmd 'LspStart'
    vim.g.isLspStart = true
  end
  require('null-ls').toggle {}
end

local on_attach = function(client, bufnr)
  -- plugins
  -- keymapping
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<space>tl', toggleLsp, bufopts)
  vim.keymap.set('n', ',lR', require('telescope.builtin').lsp_definitions, bufopts)
  vim.keymap.set('n', ',lr', require('telescope.builtin').lsp_references, bufopts)
  vim.keymap.set('n', ',ly', require('telescope.builtin').lsp_document_symbols, bufopts)
  vim.keymap.set('n', ',lY', require('telescope.builtin').lsp_workspace_symbols, bufopts)
  vim.keymap.set('n', ',ld', function()
    require('telescope.builtin').diagnostics { bufnr = 0 }
  end, bufopts)
  vim.keymap.set('n', ',lD', require('telescope.builtin').diagnostics, bufopts)
  vim.keymap.set('n', ',tc', require('telescope.builtin').commands, bufopts)
  vim.keymap.set('n', ',th', require('telescope.builtin').help_tags, bufopts)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- overwrite by lspsaga
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
end

local servers = { 'bashls', 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
  }
end

-- require('lspconfig').grammarly.setup {
--   handlers = handlers,
--   on_attach = on_attach,
--   capabilities = capabilities,
--   init_options = { clientId = 'client_BaDkMgx4X19X9UxxYRCXZo' },
-- }

-- clangd server setup
local clangd_capabilities = capabilities
clangd_capabilities.offsetEncoding = 'utf-8'

require('lspconfig').clangd.setup {
  handlers = handlers,
  capabilities = clangd_capabilities,
  on_attach = on_attach,
  single_file_support = true,
  filetype = { 'c', 'cpp' },
}

-- require('lspconfig').ltex.setup { cmd = { '/home/mhamdi/.cache/ltex-ls-15.2.0/bin/ltex-ls' } }
-- ltex: open source Grammar
-- s.getenv("HOME")
local lang = os.getenv 'PROJECT_LANG' or 'en'
require('lspconfig').ltex.setup {
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

---- lua sumneko
--require('neodev').setup {}
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
require('lspconfig').sumneko_lua.setup {
  handlers = handlers,
  capabilities = capabilities,
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },

  -- settings = {
  --   Lua = {
  --     completion = {
  --       callSnippet = 'Replace',
  --     },
  --   },
  -- },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        enable_check_codestyle = true,
        globals = {
          'packer_plugins',
          'use',
          'vim',
        },
      },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file('', true),
        },
        checkThirdParty = false, -- FIX the sumneko need config
        -- Make the server await for loading Neovim runtime files
        maxPreload = 1000,
        preloadFileSize = 500,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
-- vim.cmd 'LspStart'
-- Configure Flutter lsp through flutter-tools.nvim
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
