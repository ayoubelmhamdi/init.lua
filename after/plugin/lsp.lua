local lsp = require 'lsp-zero'

lsp.ensure_installed {
  'sumneko_lua',
  'rust_analyzer',
  'ltex-ls',
}

lsp.set_preferences {
  suggest_lsp_servers = false,
  set_lsp_keymaps = false,
}

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local n = require('ayoub.bind').n
  local i = require('ayoub.bind').i
  local f = require 'ayoub.mini_functions'

  n('gd', f.type_definition, opts)
  n('K', f.hover, opts)
  n('[d', f.goto_next, opts)
  n(']d', f.goto_prev, opts)
  n('<leader>tl', f.toggleLsp, opts)
  n('<leader>ws', f.workspace_symbol, opts)
  n('<leader>vd', f.open_float, opts)
  n('<leader>ca', f.code_action, opts)
  n('<leader>rr', f.references, opts)
  n('<leader>rn', f.rename, opts)
  i('<C-h>', f.signature_help, opts)
end)

--[[
  If you have a server installed globally
  you can use the option `force_setup` or `force = true` to skip any internal check.

  - for one server
  lsp.configure('dartls', {force_setup = true})
  - for multi servers
  lsp.setup_servers({'dartls', 'vls', force = true})
]]
--

-- xbps: dartls clangd, rust_analyzer
lsp.setup_servers { 'dartls', 'rust_analyzer', 'clangd', force = true }

-- Mason: sumneko_lua

-- lsp.configure('clangd', {
--   filetype = { 'c', 'cpp' },
-- })
local lang = os.getenv 'PROJECT_LANG' or 'en'
lsp.configure('ltex', {
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
})

lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'packer_plugins',
          'use',
          'vim',
        },
      },
      workspace = {
        checkThirdParty = false, -- FIX the sumneko need config
        -- Make the server await for loading Neovim runtime files
        maxPreload = 1000,
        preloadFileSize = 500,
      },
    },
  },
})

-- help to use some hander and capability by lsp-zero,
-- then extend the config using usaul config
lsp.preset 'lsp-compe'
lsp.setup()

-- after 'lsp-zero'.setup()
vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
}
