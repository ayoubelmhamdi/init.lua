--if true then return end
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

------------------------------luasnip-----------------------------------------------------
require('luasnip.loaders.from_lua').lazy_load()
--require('luasnip/loaders/from_snipmate').lazy_load()
local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
  history = false,
  update_events = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<-- choiceNode', 'Comment' } },
      },
    },
  },
  ext_base_prio = 300,
  ext_prio_increase = 1,
  enable_autosnippets = true,
  store_selection_keys = '<Tab>',
  ft_func = function()
    return vim.split(vim.bo.filetype, '.', true)
  end,
}
--

My_Symbols = {
  Array = ' ', -- '謹',
  Boolean = ' ', --'ﬧ ',
  Class = ' ', --' ', -- ' ', -- ' ',
  Color = ' ', -- ' ',
  Constant = ' ', -- ' ',
  Constructor = ' ', -- ' ',
  Enum = ' ', -- '練 ', -- ' ',
  EnumMember = ' ', -- ' ',
  Event = ' ', -- ' ', -- ' ',
  Field = ' ', -- ' ', -- ' ',
  File = ' ', -- ' ',
  Folder = ' ', -- ' ',
  Function = ' ',
  Interface = ' ', -- '﨡', -- ' ',
  Keyword = ' ', -- ' ', -- ' ',
  Method = ' ', -- ' ',
  Module = ' ', -- ' ',
  Namespace = ' ', -- ' ',
  Number = ' ', -- '濫',
  Object = '謹',
  Operator = '璉 ', -- ' ',
  Package = ' ', -- ' ',
  Property = ' ', -- ' ', -- ' ',
  Reference = ' ', -- ' ', -- ' ' -- ' ',
  Snippet = ' ', -- ' ', -- ' ',
  Struct = ' ', --'פּ ', -- ' ',
  Text = ' ', -- ' ',
  TypeParameter = '', --' ', -- ' ', -- ' ',
  Unit = ' ', -- '塞 ', -- 'ﰩ '  --' ',
  Value = ' ', -- ' ',
  Variable = ' ', -- ' ', -- ' ',
}

------------------------------cmp-----------------------------------------------------
local cmp = require 'cmp'

local source_mapping = {
  browser = '[BROWSER]',
  buffer = '[BUFFER]',
  look = '[LOOK]',

  nvim_lsp_signature_help = '[LSPH]',
  path = '[PATH]',
  luasnip = '[LuaSnip]',
  nvim_lsp = '[LSP]',
  nvim_lua = '[API]',
  cmp_tabnine = '[TN]',
  treesitter = '[TS]',
  cmp_matlab = '[MATLAB]',
  rg = '[RG]',
  spell = '[Spell]',
}
cmp.setup {
  sources = cmp.config.sources {
    { name = 'path', option = { trailing_slash = true }, priority = 10 },
    { name = 'nvim_lsp_signature_help', priority = 89 },
    { name = 'nvim_lsp', priority = 88 },
    { name = 'nvim_lua', priority = 87 },

    -- { name = 'cmp_tabnine', priority = 99 },

    { name = 'cmp_matlab', priority = 95 },
    { name = 'luasnip', priority = 90 },
    { name = 'treesitter', priority = 80 },
    { name = 'rg', priority = 70 },
    -- { name = 'spell' }, { name = 'spell', keyword_length = 2 },
    -- {
    --   name = 'look',
    --   priority = 60,
    --   keyword_length = 5,
    --   option = {
    --     convert_case = true,
    --     loud = true,
    --     --dict = '/usr/share/dict/words'
    --   },
    -- },
    -- {
    --   name = 'buffer',
    --   priority = 70,
    --   option = {
    --     get_bufnrs = function()
    --       local buf = vim.api.nvim_get_current_buf()
    --       local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
    --       if byte_size > 2048 * 2048 then
    --         return {}
    --       end
    --       return { buf }
    --     end,
    --   },
    -- },
    -- { name = 'browser' },
  },

  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-i>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-o>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.abort(),
    ['<c-e>'] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { 'i', 'c' }
    ),
    ['<c-space>'] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function()
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },
    ['<tab>'] = cmp.config.disable,
    ['<down>'] = cmp.config.disable,
    ['<up>'] = cmp.config.disable,
  },
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- sorting = {
  --   comparators = {
  --     function(...)
  --       return require('cmp_buffer'):compare_locality(...)
  --     end,
  --   },
  -- },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}

-- TODO: max of sug
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    {
      name = 'path',
      option = {
        trailing_slash = true,
      },
    },
  }, {
    { name = 'nvim_lua' },
  }, {
    { name = 'cmdline' },
  }),
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = 'buffer' },
  },
})

-- TODO to lua
_ = vim.cmd [[
  augroup CmpFish
    au!
    autocmd Filetype fish lua require'cmp'.setup.buffer { sources = { { name = "fish" }, } }
  augroup END
]]
-- vim.cmd [[
--   augroup CmpTex
--     au!
--     autocmd Filetype tex lua require'cmp'.setup.buffer { sources = { { name = "latex_symbols" }, } }
--   augroup END
-- ]]

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set('i', '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

--vim.keymap.set('i', '<c-u>', require 'luasnip.extras.select_choice')

-- require('cmp_tabnine.config'):setup {
--   max_lines = 40,
--   max_num_results = 2,
--   sort = true,
--   run_on_every_keystroke = true,
--   snippet_placeholder = '..',
--   ignored_file_types = { -- default is not to ignore
--     -- uncomment to ignore in lua:
--     -- lua = true
--   },
--   show_prediction_strength = true,
-- }

-- local compare = require('cmp.config.compare')
-- cmp.setup({
--   sorting = {
--     priority_weight = 2,
--     comparators = {
--       require('cmp_tabnine.compare'),
--       compare.offset,
--       compare.exact,
--       compare.score,
--       compare.recently_used,
--       compare.kind,
--       compare.sort_text,
--       compare.length,
--       compare.order,
--     },
--   },
-- })
