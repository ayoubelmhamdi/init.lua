return {
  'hrsh7th/nvim-cmp',
  -- after = "lspkind-nvim",
  event = 'InsertEnter',
  dependencies = {
    { 'onsails/lspkind.nvim', config=function ()
    My_Symbols = {

      Codeium = ' ',
      Copilot = '  ',
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
     require('lspkind').init({
    symbol_map = My_Symbols,
})
    end },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-cmdline' },
    -- { 'mstanciu552/cmp-matlab' },
    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
    --TODO test if After
    { 'neovim/nvim-lspconfig' },
    -- -- should swtich to https://github.com/kizza/cmp-rg-lsp
    -- thne create my own regex to grep all partener
    -- { 'lukas-reineke/cmp-rg' },
  },
  priority = 1,
  config = function()
    --if true then return end
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

    local lspkind = require 'lspkind'
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
    --------------------------- VARS--------------------------------------------
    -- local truncate = function(text, max_width)
    --   if #text > max_width then
    --     return string.sub(text, 1, max_width) .. '…'
    --   else
    --     return text
    --   end
    -- end
    local cmp = require 'cmp'

    local sources = cmp.config.sources {
      { name = 'codeium' },
      { name = 'path' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
      -- { name = 'treesitter'},
      -- { name = 'cmp_tabnine', priority = 99 },
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
    }

    local mapping = {
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
        c = function(
          _ --[[fallback]]
        )
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
      -- ['<down>'] = cmp.config.disable,
      -- ['<up>'] = cmp.config.disable,
    }

    local sorting = {
      -- tj sort
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,

        -- copied from cmp-under, but I don't think I need the plugin for this.
        -- I might add some more of my own.
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find '^_+'
          local _, entry2_under = entry2.completion_item.label:find '^_+'
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,

        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    }

    local formatting = {
        format = lspkind.cmp_format {
          with_text = true,
          menu = {
            buffer = '[buf]',
            nvim_lsp = '[LSP]',
            nvim_lua = '[lua]',
            path = '[path]',
            lusasnip = '[snip]',
          },
          -- defines how annotations are shown
          -- default: symbol
          -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          mode = 'text_symbol',
          -- prevent the popup from showing more than 50 chars
          maxwidth = 80,
        },
      }
    ---------------------------- CMP SETUP -------------------------------------
    cmp.setup {
      sources = sources,
      formatting = formatting,
      mapping = mapping,
      snippet = {
        expand = function(args)
          ls.lsp_expand(args.body)
        end,
      },
      sorting = sorting,
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        native_menu = false,
        ghost_text = true,
      },
    }

    ---------------------------- cmdline -------------------------------------
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

    --------------------------- MAPPING  -------------------------------------
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources {
        { name = 'buffer' },
      },
    })

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

    -------------------------------------------------------------------
  end, -- end lazyconfig-cmp
}
