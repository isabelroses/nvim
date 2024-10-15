require("izvim.config.autocmds")
require("izvim.config.ft")
require("izvim.config.keybinds")
require("izvim.config.neovide")
require("izvim.config.options")

vim.api.nvim_cmd({
  cmd = "packadd",
  args = { "lz-n" },
}, {})

require("lz.n").load(require("izvim.plugins"))
