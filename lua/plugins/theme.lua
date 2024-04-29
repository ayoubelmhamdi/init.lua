return {
    -- Test italic
    -- ||
    -- ||
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end
    },
    {
        'ellisonleao/gruvbox.nvim',
        config = function()
            -- Default options:
            require('gruvbox').setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = '', -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })

            if vim.fn.filereadable('/tmp/day') == 1 then
                vim.cmd('colorscheme github_light')
            else
                vim.cmd('colorscheme gruvbox')
                -- vim.cmd 'colorscheme edge'
                -- vim.cmd.colorscheme('gruber-darker')
                -- vim.cmd 'hi Normal guibg=#181818'
            end
        end,
    },
    {
        'blazkowolf/gruber-darker.nvim',
        config = function()
            require('gruber-darker').setup({
                bold = true,
                invert = {
                    signs = false,
                    tabline = false,
                    visual = false,
                },
                italic = {
                    strings = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                undercurl = true,
                underline = true,
            })
        end,
    },
    {
        'projekt0n/github-nvim-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                options = {
                    hide_end_of_buffer = true,
                    -- italic,bold
                    -- styles = {
                    --   comments = 'NONE',
                    --   functions = 'NONE',
                    --   keywords = 'NONE',
                    --   variables = 'NONE',
                    --   conditionals = 'NONE',
                    --   constants = 'NONE',
                    --   numbers = 'NONE',
                    --   operators = 'NONE',
                    --   strings = 'NONE',
                    --   types = 'NONE',
                    -- },
                },
            })
        end,
    },
    -- {
    --     'sainnhe/edge',
    -- },
    -- { 'd00h/nvim-rusticated' },

    {
        'echasnovski/mini.indentscope',
        version = false,
        config = function()
            require('mini.indentscope').setup({
                symbol = '',
                draw = {
                    delay = 10,
                },
            })
        end,
    },
}
