vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local REQ = require('ayoub.mini_functions').REQ

local cmp = REQ('cmp')
local lspkind = REQ('lspkind')
local luasnip = REQ('luasnip')
local copilot = REQ('copilot')
local copilot_cmp = REQ('copilot_cmp')

if not (cmp and lspkind and luasnip and copilot and copilot_cmp) then return end

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
end

local sorting = {
    priority_weight = 2,
    comparators = {
        require('copilot_cmp.comparators').prioritize,
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    },
}

local formatting = {
    format = lspkind.cmp_format({
        with_text = true,
        menu = {
            copilot = '[Cop]',
            buffer = '[buf]',
            nvim_lsp = '[LSP]',
            nvim_lua = '[lua]',
            path = '[path]',
            lusasnip = '[snip]',
        },
        -- mode = 'text_symbol',
        maxwidth = 80,
    }),
}
---------------------------- CMP SETUP -------------------------------------
cmp.setup({
    snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
    sources = cmp.config.sources({
        { name = 'copilot', group_index = 2 },
        -- { name = 'codeium' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }),
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<c-e>'] = cmp.mapping(cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }), { 'i', 'c' }),
        -- ['<Tab>'] = vim.schedule_wrap(function(fallback)
        --     if cmp.visible() and has_words_before() then
        --         cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --     else
        --         fallback()
        --     end
        -- end),
    },
    formatting = formatting,
    sorting = sorting,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

----------------------------   AI    -------------------------------------

copilot.setup()
copilot_cmp.setup()

----------------------------   DAP   -------------------------------------

cmp.setup({ enabled = function() return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer() end })
cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, { sources = { { name = 'dap' } } })

---------------------------- cmdline -------------------------------------

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' },
        { name = 'buffer' },
    }),
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    }),
})
