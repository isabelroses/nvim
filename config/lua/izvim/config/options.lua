-- true colors
vim.o.termguicolors = true

-- line numbers
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true

-- scroll offsets
vim.o.scrolloff = 5
vim.o.sidescrolloff = 15

-- completion height
vim.o.pumheight = 15

-- split directions
vim.o.splitbelow = true
vim.o.splitright = true

-- search settings
vim.o.ignorecase = true
vim.o.smartcase = true

-- redefine word boundaries - '_' is a word separator, this helps with snake_case
vim.opt.iskeyword:remove("_")

-- indentations settings
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.smartindent = true
-- enable break indent
vim.o.breakindent = true
vim.o.wrap = false

-- always show 1 column of sign column (gitsigns, etc.)
vim.o.signcolumn = "yes:1"

-- hide search notices, intro
vim.opt.shortmess:append("sI")

-- nice font icons or something
vim.g.have_nerd_font = true

-- decrease update time
vim.o.updatetime = 250
-- decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- don't show the mode, since it's already in the status line
vim.o.showmode = false
vim.o.cmdheight = 0
-- always show status
vim.o.laststatus = 3
-- keep progress (LSP loading etc.) out of the message area, the statusline shows it
vim.o.messagesopt = "hit-enter,history:500,progress:"

-- ohhhh tabs, already have bufferline
vim.o.showtabline = 0

-- use rg for grepping
vim.o.grepprg = "rg --vimgrep"

-- enable project-local configs
vim.o.exrc = true

-- let me have spelling checking for english
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")

-- indent blank line improvements
vim.o.list = true

-- disable swap and backup files, keep persistent undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fs.normalize("~/.local/state/nvim/undodir")
vim.o.undofile = true

-- borders
vim.o.winborder = "rounded"
vim.opt.fillchars:append({
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vert = "│",
  vertright = "├",
  vertleft = "┤",
  verthoriz = "┼",
})

-- fix markdown stuff
vim.g.markdown_recommended_style = 0

if vim.fn.has("unix") == 1 then
  vim.o.shell = "/run/current-system/sw/bin/sh"
end

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = { "/mnt/c/Program Files/Neovim/bin/win32yank.exe", "-i", "--crlf" },
      ["*"] = { "/mnt/c/Program Files/Neovim/bin/win32yank.exe", "-i", "--crlf" },
    },
    paste = {
      ["+"] = { "/mnt/c/Program Files/Neovim/bin/win32yank.exe", "-o", "--lf" },
      ["*"] = { "/mnt/c/Program Files/Neovim/bin/win32yank.exe", "-o", "--lf" },
    },
    cache_enabled = true,
  }
end

require("vim._core.ui2").enable({ enable = true })
