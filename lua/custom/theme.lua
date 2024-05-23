local REQ = require('ayoub.mini_functions').REQ

local indents = REQ('mini.indentscope')
local gruber = REQ('gruber-darker')
-- local gruvbox = REQ('gruvbox')
-- local github = REQ('github-theme')

if
    not (
        indents -- always load indentscope
        and gruber
        -- and gruvbox
        -- and github
    )
then
    return
end

-- Test italic
-- ||
-- ||

----------------------------- MAPPING ------------------------------------
indents.setup({
    symbol = '',
    draw = {
        delay = 10,
    },
})
-- vim.cmd.colorscheme 'ron'
-- colorizer.setup()

-- gruvbox.setup({
--     terminal_colors = true, -- add neovim terminal colors
--     undercurl = true,
--     underline = true,
--     bold = true,
--     italic = {
--         strings = false,
--         emphasis = false,
--         comments = false,
--         operators = false,
--         folds = false,
--     },
--     strikethrough = true,
--     invert_selection = false,
--     invert_signs = false,
--     invert_tabline = false,
--     invert_intend_guides = false,
--     inverse = true, -- invert background for search, diffs, statuslines and errors
--     contrast = '', -- can be "hard", "soft" or empty string
--     palette_overrides = {},
--     overrides = {},
--     dim_inactive = false,
--     transparent_mode = false,
-- })

-- github.setup({
--     options = {
--         hide_end_of_buffer = true,
--         -- italic,bold
--         -- styles = {
--         --   comments = 'NONE',
--         --   functions = 'NONE',
--         --   keywords = 'NONE',
--         --   variables = 'NONE',
--         --   conditionals = 'NONE',
--         --   constants = 'NONE',
--         --   numbers = 'NONE',
--         --   operators = 'NONE',
--         --   strings = 'NONE',
--         --   types = 'NONE',
--         -- },
--     },
-- })

gruber.setup({
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

vim.cmd.colorscheme('gruber-darker')
-- vim.cmd.colorscheme 'edge'
-- vim.cmd.colorscheme 'github_light'

if vim.fn.filereadable('/tmp/day') == 1 then
    vim.cmd.colorscheme('gruber-darker')
end
