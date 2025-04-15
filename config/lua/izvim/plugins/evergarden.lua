return {
  {
    "evergarden",
    after = function()
      require("evergarden").setup({
        theme = {
          variant = "winter",
          accent = "pink",
        },
        editor = {
          transparent_background = false,
          override_terminal = true,
        },
        style = {
          tabline = { "reverse" },
          search = { "reverse" },
          incsearch = { "reverse" },
          types = { "italic" },
          keyword = {},
          comment = { "italic" },
        },
        overrides = {}, -- add custom overrides
      })
    end,
  },
  {
    "cuddlefish.nvim",
    after = function()
      require("cuddlefish").setup({
        overrides = {},
      })

      vim.cmd.colorscheme [[cuddlefish]]
    end
  },
}
