return {
  {
    "toggleterm.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("toggleterm").setup({
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = "1",
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        float_opts = {
          border = "rounded",
        },
      })

      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<c-t>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
    end,
  },
}
