-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
if true then return end
local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    print('nvim-tree unavailable')
    return
end

local config_status_ok, nvim_tree_config = pcall(require, 'nvim-tree.config')
if not config_status_ok then
    print('nvim-tree.config unavailable')
    return
end

nvim_tree.setup({
    open_on_setup = true,
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    renderer = {
        icons = {
            glyphs = {
                default = '',
                symlink = '',
                git = {
                    unstaged = '',
                    staged = 'S',
                    unmerged = '',
                    renamed = '➜',
                    deleted = '',
                    untracked = 'U',
                    ignored = '◌',
                },
                folder = {
                    default = '',
                    open = '',
                    empty = '',
                    empty_open = '',
                    symlink = '',
                },
            },
        },
        root_folder_modifier = ':t',
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
        },
    },
})
