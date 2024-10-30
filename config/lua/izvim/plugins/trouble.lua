return {
  {
    "trouble.nvim",
    after = function()
      local trouble = require("trouble")
      trouble.setup({})

      vim.keymap.set("n", "<leader>tt", function()
        trouble.toggle()
      end, { noremap = true, silent = true })

      vim.keymap.set("n", "[d", function()
        trouble.next({ skip_groups = true, jump = true })
      end, { noremap = true, silent = true })

      vim.keymap.set("n", "]d", function()
        trouble.previous({ skip_groups = true, jump = true })
      end, { noremap = true, silent = true })
    end,
  },
}
