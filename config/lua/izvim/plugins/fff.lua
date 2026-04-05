return {
  {
    "fff.nvim",
    lazy = false,
    after = function()
      require("fff").setup({
        prompt = "> ",
        title = "Find files",
        max_threads = 8,
        preview = {
          line_numbers = true,
          show_file_info = false,
        },
      })

      local map = function(mode, shortcut, command, opt)
        opt = opt or { noremap = true, silent = true }
        vim.keymap.set(mode, shortcut, command, opt)
      end

      map("n", "<leader><leader>", function()
        require("fff").find_files()
      end) -- find files
      map("n", "<leader>fg", function()
        require("fff").live_grep({
          grep = {
            modes = { "fuzzy", "plain" },
          },
        })
      end) -- grep through all files
      -- map("n", "<leader>fs", "<cmd>SessionManager load_session<cr>") -- Show nvim sessions
      -- map("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>") -- search help tags
      -- map("n", "<leader>ft", "<cmd>TodoFzfLua<cr>") -- live grep but for TODOs and FIXMEs
      -- map("n", "<leader>fz", "<cmd>FzfLua zoxide<cr>") -- list recent dirs
    end,
  },
}
