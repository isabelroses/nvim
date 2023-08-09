local opt = vim.opt

opt.conceallevel = 1 -- so that `` is visible in markdown files
opt.clipboard = "" -- use system clipboard
opt.laststatus = 3 -- always show statusline
opt.cmdheight = 0 -- height of command bar
opt.updatetime = 100 -- faster completion
opt.list = false -- show whitespace characters
opt.cursorline = false -- highlight current line
opt.clipboard = "unnamedplus" -- sync clipboard with os

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
