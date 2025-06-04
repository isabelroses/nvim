return {
  -- tree view
  {
    "nvim-tree.lua",
    event = "DeferredUIEnter",
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

  -- add better undo history
  {
    "undotree",
    event = "BufReadPost",
    after = function()
      require("undotree").setup()
      vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
    end,
  },

  -- track my time coding
  {
    "vim-wakatime",
    event = "VimEnter",
    enabled = function()
      return vim.fn.glob("~/.wakatime.cfg") ~= "" or vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= ""
    end,
  },

  {
    "direnv.nvim",
    event = "VimEnter",
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
    event = "VimEnter",
    after = function()
      require("cord").setup({
        editor = { icon = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp" },
        display = { swap_icons = true },
      })
    end,
  },

  {
    "gitsigns.nvim",
    event = "BufReadPost",
    after = function()
      require("gitsigns").setup()
    end,
  },
}
