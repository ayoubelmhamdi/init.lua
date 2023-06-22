return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.1',
    lazy = true,
    event = 'VeryLazy',
    cmd = 'Telescope',
    dependencies = {
      'cljoly/telescope-repo.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      local builtin = require 'telescope.builtin'
      local function grep_string()
        builtin.grep_string { search = vim.fn.input 'Grep > ' }
      end
      vim.keymap.set('n', '<C-p>', ':Telescope repo list<cr>', {})
      vim.keymap.set('n', '<C-l>', ':Telescope find_files<cr>', {})
      vim.keymap.set('n', '<leader>lf', ':Telescope find_files<cr>', {})
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

      require('telescope').setup {
        defaults = {
          initial_mode = 'insert',
          scroll_strategy = 'limit',
          results_title = false,
          layout_strategy = 'horizontal',
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
      }

      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'repo'
      require('telescope').load_extension 'harpoon'
    end,
  },
}
