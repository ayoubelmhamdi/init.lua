local REQ = require('ayoub.mini_functions').REQ

local telescope = REQ('telescope')
local builtin = REQ('telescope.builtin')
local actions = REQ('telescope.actions')
local previewers = REQ('telescope.previewers')
local sorters = REQ('telescope.sorters')

if not (telescope and builtin and actions) then return end


----------------------------- MAPPING ------------------------------------

local find_command = {'-g', '!.git', '-g', '!node_modules', '-g', '!package-lock.json', '-g', '!yarn.lock', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--no-ignore'}


local function grep_string()
    builtin.grep_string({
        use_regex=true,
        additional_args=find_command,
        search = vim.fn.input('Grep > '),
    })
end

local function git_or_find_files()
    local in_git_repo = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
    if in_git_repo then
        builtin.git_files({ show_untracked = true })
    else
        builtin.find_files()
    end
end

local opt = { noremap = true, silent = true }
vim.keymap.set('n', '<space><C-P>', ':Telescope repo list<cr>', opt)
vim.keymap.set('n', '<space><C-L>', git_or_find_files, opt)
vim.keymap.set('n', '<space><C-F>', ':Telescope find_files<cr>', opt)
vim.keymap.set('n', '<space><C-S>', grep_string)

---------------------------- TELESCOPE -----------------------------------

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


telescope.setup({
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
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            },
            n = {
                ['q'] = actions.close,
                ['<ESC>'] = actions.close,
            },
        },
    },
    extensions = {
        repo = telescope_repo,
        fzf = telescope_fzf,
    },
})

telescope.load_extension('fzf')
telescope.load_extension('repo')
telescope.load_extension('harpoon')
