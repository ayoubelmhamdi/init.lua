return {
    -- if we don't use tiletype, the event=verylazy/lazy=true, triggle off the plugin.
    {
        'khzaw/vim-conceal',
        ft = { 'python', 'ocamel', 'ruby' },
    },
    { 'MrPicklePinosaur/typst-conceal.vim', ft = 'typst' },
}
