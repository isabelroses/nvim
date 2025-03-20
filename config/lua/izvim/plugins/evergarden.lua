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
          transparent_background = true,
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
      vim.cmd.colorscheme("evergarden")
    end,
  },
}
