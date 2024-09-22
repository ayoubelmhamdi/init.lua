--- A Neovim module for grep-based quickfix list population using Rg.

local M = {}

M.execute_rg = function(pattern, ExtMode)
    local command = nil
    if ExtMode then
        extension = vim.fn.input('Extension > ')
        command = string.format("rg --vimgrep %s -g \\*.%s", vim.fn.shellescape(pattern), extension)
    else
        command = string.format("rg --vimgrep %s", vim.fn.shellescape(pattern))
    end


    local output = vim.fn.system(command)
    
    if vim.v.shell_error ~= 0 then
        print("Error executing rg command: " .. output)
        return {}
    end
    
    output = vim.trim(output)
    if output == "" then
        print("No results found for pattern: " .. pattern)
        return {}
    end
    
    local results = vim.split(output, "\n")
    local qf_list = {}
    
    for _, line in ipairs(results) do
        local filename, lnum, col, text = line:match("([^:]+):(%d+):(%d+):(.*)")
        if filename and lnum and col and text then
            table.insert(qf_list, {
                filename = filename,
                lnum = tonumber(lnum),
                col = tonumber(col),
                text = vim.trim(text)
            })
        end
    end
    
    return qf_list
end


M.main = function(ExtMode, pattern)
    if not vim.fn.executable('rg') == 1 then
        print("Rg (ripgrep) is not available. Please install it.")
        return
    end

    if pattern == '' then
        print("No pattern provided. Exiting.")
        return
    end

    vim.opt.errorformat = "%f:%l:%c:%m"

    local qf_list = M.execute_rg(pattern, ExtMode)

    if #qf_list > 0 then
        vim.fn.setqflist({}, 'r', { title = 'Grep Results: ' .. pattern, items = qf_list })
        vim.cmd('copen')
    end
end

return M
