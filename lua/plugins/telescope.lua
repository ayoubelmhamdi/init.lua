return {
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.4',
        lazy = true,
        event = 'VeryLazy',
        cmd = 'Telescope',
        dependencies = {
            'cljoly/telescope-repo.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            local builtin = require('telescope.builtin')
            local function grep_string()
                builtin.grep_string({
                    find_command = {
                        'rg',
                        '-g',
                        '!.git',
                        '-g',
                        '!node_modules',
                        '-g',
                        '!package-lock.json',
                        '-g',
                        '!yarn.lock',
                        '--hidden',
                        '--no-ignore-global',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                    },
                    ignore_case = true,
                    search = vim.fn.input('Grep > '),
                })
            end
            local function git_or_find_files()
                local in_git_repo = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
                if in_git_repo then
                    builtin.git_files({show_untracked = true})
                else
                    builtin.find_files()
                end
            end
            local opt = { noremap = true, silent = true }

            vim.keymap.set('n', '<C-p>', ':Telescope repo list<cr>', opt)
            vim.keymap.set('n', '<C-l>', git_or_find_files, opt)
            vim.keymap.set('n', '<leader>lf', ':Telescope find_files<cr>', opt)
            vim.keymap.set('n', '<leader>ls', grep_string)

            local file_ignore_patterns = {
                '.git/',
                '.cache',
                '%.class',
                '%.mkv',
                '%.mp4',
                '%.zip',
                'LICENSE',
                '%.pdf',
                '%.jpg',
                '%.png',
            }

            local telescope_repo = {
                list = {
                    fd_opts = {
                        '--no-ignore-vcs',
                    },
                    search_dirs = {
                        '/data/projects',
                        '~/.config',
                    },
                },
            }
            local telescope_fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                ovveride_file_sorter = true,
                case_mode = 'smart_case',
            }

            local extensions = {
                repo = telescope_repo,
                fzf = telescope_fzf,
            }

            local mappings = {
                i = {
                    ['<C-j>'] = require('telescope.actions').move_selection_next,
                    ['<C-k>'] = require('telescope.actions').move_selection_previous,
                },
                n = {
                    ['q'] = require('telescope.actions').close,
                    ['<ESC>'] = require('telescope.actions').close,
                },
            }

            local layout_config = {
                width = 0.99,
                height = 0.99,
                -- preview_cutoff = 120,
                prompt_position = 'top',
                horizontal = {
                    preview_width = function(_, cols, _)
                        if cols > 200 then
                            return math.floor(cols * 0.4)
                        else
                            return math.floor(cols * 0.6)
                        end
                    end,

                    preview_cutoff = 10,
                },
                vertical = {
                    width = 0.95,
                    height = 0.95,
                    preview_height = 0.8,
                    preview_cutoff = 10,
                },
                flex = {
                    horizontal = {
                        preview_width = 0.9,
                    },
                },
            }

            require('telescope').setup({
                defaults = {
                    selection_strategy = 'reset',
                    sorting_strategy = 'descending',
                    color_devicons = true,
                    initial_mode = 'insert',
                    results_title = false,
                    -- layout_strategy = 'vertical',
                    layout_strategy = 'horizontal',
                    -- layout_strategy = 'flex',
                    layout_config = layout_config,
                    --
                    path_display = { 'absolute' },
                    file_ignore_patterns = file_ignore_patterns,
                    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
                    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
                    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
                    file_sorter = require('telescope.sorters').get_fuzzy_file,
                    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
                    mappings = mappings,
                },
                extensions = extensions,
            })

            require('telescope').load_extension('fzf')
            require('telescope').load_extension('repo')
            require('telescope').load_extension('harpoon')
        end,
    },
}
