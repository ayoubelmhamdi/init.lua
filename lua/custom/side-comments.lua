local M = {}


local conceal_defaults = {
  python = 38,
  c = 40,
}

local conceal_active = {}


function M.setup(opts)
  opts = opts or {}
  _G.conceal_langs = vim.tbl_extend("force", conceal_defaults, _G.conceal_langs or {}, opts)

  local group = vim.api.nvim_create_augroup("SideComments", { clear = true })


  vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    callback = function()
      if conceal_active[vim.api.nvim_get_current_buf()] then
        vim.wo.conceallevel = 0
      end
    end,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    callback = function()
      if conceal_active[vim.api.nvim_get_current_buf()] then
        vim.wo.conceallevel = 2
      end
    end,
  })

  vim.keymap.set("n", "<leader>tc", M.toggle, { desc = "Toggle conceal prefix" })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function()
      local ft = vim.bo.filetype
      if (_G.conceal_langs or {})[ft] then
        vim.wo.concealcursor = "nv"
        vim.schedule(function()
          M.toggle_side_comments(true)
        end)
      end
    end,
  })

  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      if conceal_active[buf] then
        vim.wo.conceallevel = 2
        vim.wo.concealcursor = "nv"
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufDelete", {
    group = group,
    callback = function(args)
      conceal_active[args.buf] = nil
    end,
  })
end

local function get_n()
  return (_G.conceal_langs or {})[vim.bo.filetype] or 0
end


function M.toggle()
  local buf = vim.api.nvim_get_current_buf()

  if conceal_active[buf] then
    vim.cmd("syntax clear HidePrefix")
    vim.wo.conceallevel = 0
    conceal_active[buf] = nil
  else
    local n = get_n()
    if n == 0 then
      vim.notify("No conceal width for filetype: " .. (vim.bo.filetype or "none"), vim.log.levels.WARN)
      return
    end
    local dots = string.rep(".", n)
    vim.cmd(string.format([[syntax match HidePrefix /^%s/ conceal cchar=+]], dots))
    vim.wo.conceallevel = 2
    vim.wo.concealcursor = "nv"
    conceal_active[buf] = true
  end
end

-- Enable/disable explicitly (mirrors your toggle_side_comments bool API)
function M.toggle_side_comments(enable)
  local buf = vim.api.nvim_get_current_buf()

  if enable then
    local n = get_n()
    if n == 0 then
      vim.notify("No conceal width for filetype: " .. (vim.bo.filetype or "none"), vim.log.levels.WARN)
      return
    end
    local dots = string.rep(".", n)
    vim.cmd(string.format([[syntax match HidePrefix /^%s/ conceal cchar=+]], dots))
    vim.wo.conceallevel = 2
    vim.wo.concealcursor = "nv"
    conceal_active[buf] = true
  else
    vim.cmd("syntax clear HidePrefix")
    vim.wo.conceallevel = 0
    conceal_active[buf] = nil
  end
end

return M
