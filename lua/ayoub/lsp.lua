local M = {}

M.capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

M.handlers = {
  ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = true,
  }),
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

M.on_attach = function(client, bufnr)
  -- plugins
  -- keymapping
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
  vim.keymap.set('n', '<space>tl', M.toggleLsp, bufopts)
  vim.keymap.set('n', ',lR', require('telescope.builtin').lsp_definitions, bufopts)
  vim.keymap.set('n', ',lr', require('telescope.builtin').lsp_references, bufopts)
  vim.keymap.set('n', ',ly', require('telescope.builtin').lsp_document_symbols, bufopts)
  vim.keymap.set('n', ',lY', require('telescope.builtin').lsp_workspace_symbols, bufopts)
  vim.keymap.set('n', ',ld', require('telescope.builtin').diagnostics, bufopts)
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

vim.g.isLspStart = true
M.toggleLsp = function()
  if vim.g.isLspStart then
    vim.cmd 'LspStop'
    vim.g.isLspStart = false
  else
    vim.cmd 'LspStart'
    vim.g.isLspStart = true
  end
  require('null-ls').toggle {}
end

M.mylspconfig = function()
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
    {
      name = 'DiagnosticSignError',
      text = '',
      texthl = 'DiagnosticError',
      linehl = {},
      numhl = 'DiagnosticLineNrError',
    },
    {
      name = 'DiagnosticSignWarn',
      text = 'כֿ',
      texthl = 'DiagnosticWarn',
      linehl = {},
      numhl = 'DiagnosticLineNrWarn',
    },
    {
      name = 'DiagnosticSignHint',
      text = '',
      texthl = 'DiagnosticInfo',
      linehl = {},
      numhl = 'DiagnosticLineNrInfo',
    },
    {
      name = 'DiagnosticSignInfo',
      text = '',
      texthl = 'DiagnosticHint',
      linehl = {},
      numhl = 'DiagnosticLineNrHint',
    },
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
end
return M
