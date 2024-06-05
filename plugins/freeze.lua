return function()
  local wk = require("which-key")

  wk.register({
    ["<leader>sc"] = { ":Freeze<cr>", "Snapshot code" },
  }, { mode = "v" })

  require("freeze").setup({
    output = function()
      return "./" .. os.date("%Y-%m-%d") .. "_freeze.png"
    end,
    config = "user",
    font = {
      family = "JetBrains Mono",
    },
  })
end
