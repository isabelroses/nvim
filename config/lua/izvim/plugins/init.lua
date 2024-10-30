return {
  -- tree view
  {
    "nvim-tree.lua",
    after = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        diagnostics = { enable = true },
        renderer = {
          indent_markers = { enable = true },
          icons = { web_devicons = { folder = { enable = true } } },
        },
        modified = { enable = true },
      })
    end,
  },

  -- mini
  {
    "mini.surround",
    event = "InsertEnter",
    after = function()
      require("mini.surround").setup({
        mappings = {
          add = "S", -- Add surrounding in Normal and Visual modes
          delete = "ds", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "cs", -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`
          suffix_last = "", -- Suffix to search with "prev" method
          suffix_next = "", -- Suffix to search with "next" method
        },
      })
    end,
  },

  -- lsp
  { "rainbow-delimiters.nvim" },

  -- rust lsp + formmating
  {
    "rustaceanvim",
    ft = "rust",
  },

  {
    "lazydev.nvim",
    after = function()
      require("lazydev").setup()
    end,
  },

  -- add better undo history
  {
    "undotree",
    after = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },

  -- track my time coding
  {
    "wakatime",
    enabled = function()
      return vim.fn.glob("~/.wakatime.cfg") ~= "" or vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= ""
    end,
  },

  -- lazygit integration & terminal
  {
    "toggleterm.nvim",
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

  {
    "direnv.nvim",
    enabled = function()
      return vim.fn.executable("direnv") == 1
    end,
    after = function()
      require("direnv").setup({
        autoload_direnv = true,
      })
    end,
  },

  -- discord integration
  {
    "cord.nvim",
    after = function()
      require("cord").setup({
        editor = { image = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp" },
        display = { swap_icons = true }, -- place the editor image as the main image
      })
    end,
  },
}
