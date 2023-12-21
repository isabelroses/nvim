local map = function(mode, shortcut, command, opt)
	opt = opt or { noremap = true, silent = true }
	vim.keymap.set(mode, shortcut, command, opt)
end

-- merge conflicts
map("n", "gd", ":diffget")
map("n", "gdh", ":diffget //2<CR>")
map("n", "gdl", ":diffget //3<CR>")

-- escape :terminal easier
map("t", "<Esc>", "<C-\\><C-n>")

-- vertical movment
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- NvimTree
map("n", "<C-N>", ":NvimTreeToggle<CR>")
