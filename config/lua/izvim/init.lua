require("izvim.config.disable")

require("izvim.config.autocmds")
require("izvim.config.ft")
require("izvim.config.keybinds")
require("izvim.config.neovide")
require("izvim.config.options")

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup('lsp:setup', { clear = true }),
  callback = function()
    require('izvim.config.lsp')
  end,
  once = true,
})

require("lz.n").load("izvim.plugins")

require("izvim.health").loaded = true
