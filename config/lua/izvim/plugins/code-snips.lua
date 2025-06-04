return {
  {
    "freeze.nvim",
    event = "DeferredUIEnter",
    after = function()
      vim.keymap.set("v", "<leader>sc", "<cmd>Freeze<cr>")

      require("freeze").setup({
        output = function()
          return vim.fn.getcwd() .. "/" .. os.date("%Y-%m-%d") .. "_freeze.png"
        end,
        config = "user",
        font = {
          family = "JetBrains Mono",
        },
      })
    end,
  },

  {
    "sayama.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("sayama").setup({
        dir = vim.fn.glob("$XDG_DATA_HOME/zzz"),
      })
    end,
  },
}
