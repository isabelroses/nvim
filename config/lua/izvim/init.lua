-- order matters here
require("izvim.config.disable")

require("izvim.config.autocmds")
require("izvim.config.ft")
require("izvim.config.keybinds")
require("izvim.config.neovide")
require("izvim.config.options")

require("lz.n").load("izvim.plugins")
require("izvim.config.lsp")

require("izvim.health").loaded = true
