vim.g.mapleader = " "
vim.g.maplocalleader = " m"

local map = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("n", "<A-k>", "<cmd>m .-2<cr>==")
map("v", "J", "<cmd>m '>+1<CR>gv=gv")
map("v", "K", "<cmd>m '<-1<CR>gv=gv")

-- vertical movement
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- native undotree, see |undotree-plugin|
map("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end)

-- toggle a quickfix list of all diagnostics, `[d` and `]d` jump between them
map("n", "<leader>tt", function()
  local qf = vim.fn.getqflist({ winid = 0, title = 0 })
  if qf.winid ~= 0 and qf.title == "Diagnostics" then
    vim.cmd.cclose()
  else
    vim.diagnostic.setqflist({ title = "Diagnostics" })
  end
end)

-- improved clipboard
map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "<leader>p", '"+p')

map({ "n", "v" }, "<leader>q", "<cmd>qall<cr>")

map("n", "<C-s>", "<cmd>w<cr>")
