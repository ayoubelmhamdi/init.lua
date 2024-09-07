local REQ = require('ayoub.mini_functions').REQ
local conform = REQ('conform')
if not conform then return end

-- 1--
-- 1--

require('conform.formatters.shfmt').args = { '-i', '4', '-filename', '$FILENAME' }
conform.setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_fix', 'isort' }, -- Conform will run multiple formatters sequentially
        javascript = { { 'prettierd', 'prettier' } }, -- Use a sub-list to run only the first available formatter
        css = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        yaml = { { 'prettierd', 'prettier' } },
        markdown = { 'mdformat' },
        sh = { 'shfmt', 'shellcheck' },
        bash = { 'shfmt', 'shellcheck' },
        json = { 'fixjson', 'jq' },
        jsonc = { 'fixjson', 'jq' },
        javascriptreact = { { 'prettied', 'prettier', 'eslint_c' } },
        typescriptreact = { { 'prettied', 'prettier', 'eslint_c' } },
        javascript = { { 'prettied', 'prettier', 'eslint_c' } },
        typescript = { { 'prettied', 'prettier', 'eslint_c' } },
    },
})
