---@type lz.n.PluginSpec[]
return {
  -- mini
  {
    "mini.surround",
    event = "InsertEnter",
    after = function()
      require("mini.surround").setup({
        mappings = {
          add = "S",
          delete = "ds",
          replace = "cs",
          update_n_lines = "sn",
          suffix_last = "",
          suffix_next = "",
        },
      })
    end,
  },

  -- track my time coding
  {
    "vim-wakatime",
    event = "VimEnter",
    enabled = function()
      return vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= "" or vim.fn.glob("~/.wakatime.cfg") ~= ""
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

  {
    "nivvie-nvim",
    lazy = false,
    after = function()
      -- don't auto restore because i want to always show the dashboard, then
      -- load it myself
      require("nivvie").setup({ autorestore = false })
    end,
  },
}
