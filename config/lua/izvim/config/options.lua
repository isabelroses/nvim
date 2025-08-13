-- netrw is handled by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
-- Enable break indent
vim.opt.breakindent = true
vim.o.wrap = false

-- always show 1 column of sign column (gitsigns, etc.)
vim.o.signcolumn = "yes:1"

-- hide search notices, intro
vim.opt.shortmess:append("sI")

-- hide extra text
vim.opt.conceallevel = 0

-- nice font icons or something
vim.g.have_nerd_font = true

-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.o.cmdheight = 0
-- always show status
vim.o.laststatus = 3

-- ohhhh tabs, already have bufferline
vim.o.showtabline = 0

-- use rg for grepping
vim.opt.grepprg = "rg --vimgrep"

-- let me have spelling checking for english
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")

-- indent blank line imporvments
vim.opt.list = true

-- disable swap, backup, and undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undodir"
vim.opt.undofile = true

local borderchars = {
  single = {
    style = "single",
    vert = "│",
    vertleft = "┤",
    vertright = "├",
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
    verthoriz = "┼",
    topleft = "┌",
    topright = "┐",
    botleft = "└",
    botright = "┘",
  },
  double = {
    style = "double",
    vert = "║",
    vertleft = "╣",
    vertright = "╠",
    horiz = "═",
    horizup = "╩",
    horizdown = "╦",
    verthoriz = "╬",
    topleft = "╔",
    topright = "╗",
    botleft = "╚",
    botright = "╝",
  },
  rounded = {
    style = "rounded",
    vert = "│",
    vertleft = "┤",
    vertright = "├",
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
    verthoriz = "┼",
    topleft = "╭",
    topright = "╮",
    botleft = "╰",
    botright = "╯",
  },
}

-- my custom borderchars
vim.o.winborder = "rounded"
vim.g.bc = borderchars.rounded
vim.opt.fillchars:append({
  horiz = vim.g.bc.horiz,
  horizup = vim.g.bc.horizup,
  horizdown = vim.g.bc.horizdown,
  vert = vim.g.bc.vert,
  vertright = vim.g.bc.vertright,
  vertleft = vim.g.bc.vertleft,
  verthoriz = vim.g.bc.verthoriz,
})

-- rust save
vim.g.rustfmt_autosave = 1

-- fix markfown stuff
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
