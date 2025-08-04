return {
  {
    "snacks.nvim",
    priority = 1000,
    after = function()
      local snacks = require("snacks")

      ---@type snacks.Config
      local opts = {
        bigfile = { enabled = true },
        quickfile = {
          enabled = true,
          exclude = { "latex" },
        },
        input = { enabled = true },

        -- undo defaults
        notifier = { enabled = false },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = false },
        picker = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
      }

      snacks.setup(opts)
    end,
  },
}
