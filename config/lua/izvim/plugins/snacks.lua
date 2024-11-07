return {
  {
    "snacks.nvim",
    priority = 1000,
    config = function()
      local snacks = require("snacks")

      snacks.setup({
        bigfile = { enabled = true },
        quickfile = {
          enabled = true,
          exclude = { "latex" },
        },

        -- undo defaults
        notifier = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
      })
    end,
  },
}
