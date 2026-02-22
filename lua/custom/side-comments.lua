local M = {}


local conceal_defaults = {
  python = 38,
  c = 40,
}

local conceal_active = {}


function M.setup(opts)
  opts = opts or {}
  _G.conceal_langs = vim.tbl_extend("force", conceal_defaults, _G.conceal_langs or {}, opts)

  vim.opt.concealcursor = "nv"

  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      vim.opt.conceallevel = 0
    end,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if conceal_active[vim.api.nvim_get_current_buf()] then
        vim.opt.conceallevel = 2
      end
    end,
  })

  vim.keymap.set("n", "<leader>tc", M.toggle, { desc = "Toggle conceal prefix" })
end

local function get_n()
  return (_G.conceal_langs or {})[vim.bo.filetype] or 0
end


function M.toggle()
  local buf = vim.api.nvim_get_current_buf()

  if conceal_active[buf] then
    vim.cmd("syntax clear HidePrefix")
    vim.opt.conceallevel = 0
    conceal_active[buf] = nil
  else
    local n = get_n()
    local dots = string.rep(".", n)
    vim.cmd(string.format([[syntax match HidePrefix /^%s/ conceal cchar=+]], dots))
    vim.opt.conceallevel = 2
    conceal_active[buf] = true
  end
end

-- Enable/disable explicitly (mirrors your toggle_side_comments bool API)
function M.toggle_side_comments(enable)
  local buf = vim.api.nvim_get_current_buf()

  if enable then
    local n = get_n()
    local dots = string.rep(".", n)
    vim.cmd(string.format([[syntax match HidePrefix /^%s/ conceal cchar=+]], dots))
    vim.opt.conceallevel = 2
    conceal_active[buf] = true
  else
    vim.cmd("syntax clear HidePrefix")
    vim.opt.conceallevel = 0
    conceal_active[buf] = nil
  end
end

return M
