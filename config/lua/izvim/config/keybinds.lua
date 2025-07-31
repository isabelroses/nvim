-- set space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " m"

local map = function(mode, shortcut, command, opt)
  opt = opt or { noremap = true, silent = true }
  vim.keymap.set(mode, shortcut, command, opt)
end

-- move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("n", "<A-k>", "<cmd>m .-2<cr>==")
map("v", "J", "<cmd>m '>+1<CR>gv=gv")
map("v", "K", "<cmd>m '<-1<CR>gv=gv")

-- vertical movment
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- NvimTree
map("n", "<C-N>", "<cmd>NvimTreeToggle<CR>")

-- improved clipboard
map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "<leader>p", '"+p')

-- quit all
map({ "n", "v" }, "<leader>q", "<cmd>qall<cr>")

-- save file
map("n", "<C-s>", "<cmd>w<cr>")
