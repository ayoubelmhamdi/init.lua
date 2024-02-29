local M = {}

local harpoon = require('harpoon')

M.A = function()
    local marks = harpoon.get_mark_config().marks
    local len = table.maxn(marks)
    if len > 0 then
        require("harpoon.ui").toggle_quick_menu()
    else
        print("Mark list = 0")
    end

end

return M
