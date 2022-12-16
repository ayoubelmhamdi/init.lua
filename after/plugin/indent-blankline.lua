    vim.cmd [[
        hi Indent1 guifg=#3A2A1A guibg=NONE
        hi Indent2 guifg=#3A2A1A guibg=NONE
        hi Indent3 guifg=#3A2A1A guibg=NONE
        hi Indent4 guifg=#3A2A1A guibg=NONE
        hi Indent5 guifg=#3A2A1A guibg=NONE
        hi Indent6 guifg=#3A2A1A guibg=NONE
    ]]

    require('indent_blankline').setup {
      show_end_of_line = true,
      char_highlight_list = {
        'Indent1',
        'Indent2',
        'Indent3',
        'Indent4',
        'Indent5',
        'Indent6',
      },
    }

