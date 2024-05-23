return {
    -- if we don't use filetype, the event=verylazy/lazy=true may turn off this plugin.
    {
        'khzaw/vim-conceal',
        ft = { 'python', 'ocamel', 'ruby' },
    },
    { 'MrPicklePinosaur/typst-conceal.vim', ft = 'typst' },
}
