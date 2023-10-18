local M = {}

function M.OpenQuickfix(text)
    text = text or ""
    vim.cmd('silent make' .. text)
    -- local qflist = vim.fn.getqflist()
    -- if #qflist > 0 then
    --     vim.cmd('copen')
    -- end
end

return M
