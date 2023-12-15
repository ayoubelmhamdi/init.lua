return {
    'chentoast/marks.nvim',
    config = function()
        require('marks').setup({
            force_write_shada = false,
            mappings = {
                set_next = 'm,',
                next = 'm]',
                preview = 'm:',
                set_bookmark0 = 'm0',
                delete_bookmark = "dm'",
                -- prev = false, -- pass false to disable only this default mapping
            },
            bookmark_0 = {
                sign = '⚑',
                --virt_text = 'hello world',
                -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
                -- defaults to false.
                annotate = false,
            },
        })
    end,
}
