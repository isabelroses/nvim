vim.o.termguicolors = true

vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true

-- scroll offsets
vim.o.scrolloff = 5
vim.o.sidescrolloff = 15

vim.o.pumheight = 15

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.ignorecase = true
vim.o.smartcase = true

-- redefine word boundaries - '_' is a word separator, this helps with snake_case
vim.opt.iskeyword:remove("_")

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.wrap = false

-- always show 1 column of sign column (gitsigns, etc.)
vim.o.signcolumn = "yes:1"

-- hide search notices, intro
vim.opt.shortmess:append("sI")

vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- don't show the mode, since it's already in the status line
vim.o.showmode = false
vim.o.cmdheight = 0
vim.o.laststatus = 3
-- keep progress (LSP loading etc.) out of the message area, the statusline shows it
vim.o.messagesopt = "hit-enter,history:500,progress:"

-- ohhhh tabs, already have bufferline
vim.o.showtabline = 0

-- use rg for grepping, skipping the same paths as the fzf-lua pickers
vim.g.izvim_search_ignore = vim.api.nvim_get_runtime_file("search-ignore", false)[1]
vim.o.grepprg = "rg --vimgrep --smart-case --ignore-file " .. vim.fn.fnameescape(vim.g.izvim_search_ignore)

vim.o.exrc = true

-- let me have spelling checking for english
vim.opt.spelloptions:append("noplainbuffer")

-- indent blank line improvements
vim.o.list = true

-- disable swap and backup files, keep persistent undo
vim.o.swapfile = false
vim.o.undodir = vim.fs.normalize("~/.local/state/nvim/undodir")
vim.o.undofile = true

vim.o.winborder = "rounded"
vim.opt.fillchars:append({
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vert = "│",
  vertright = "├",
  vertleft = "┤",
  verthoriz = "┼",
  eob = " ", -- hide the ~ on lines past the end of the buffer
})
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"

-- highlight the current line number only, not the whole line
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- preview :s substitutions in a split with every match
vim.o.inccommand = "split"
vim.opt.wildoptions:append("fuzzy")
-- ask to save instead of erroring on :q with unsaved changes
vim.o.confirm = true
-- let visual-block selections go past the end of short lines
vim.o.virtualedit = "block"
-- keep text where it is on screen when splits open or close (explorer, quickfix)
vim.o.splitkeep = "screen"
-- restore the scroll position when jumping back through the jumplist
vim.opt.jumpoptions:append("view")
-- better diffs for moved/reordered code
vim.opt.diffopt:append("algorithm:histogram")
vim.o.undolevels = 10000

-- don't run regex syntax past column 300, minified files are slow otherwise.
-- treesitter highlighting is unaffected
vim.o.synmaxcol = 300

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
