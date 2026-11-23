---@type lz.n.PluginSpec[]
return {
  {
    "freeze.nvim",
    event = "DeferredUIEnter",
    after = function()
      vim.keymap.set("v", "<leader>sc", "<cmd>Freeze<cr>")

      require("freeze").setup({
        output = function()
          return vim.fn.getcwd() .. "/" .. os.date("%Y-%m-%d") .. "_freeze.png"
        end,
        config = "user",
        font = { family = "JetBrains Mono" },
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
    "nivvie-nvim",
    lazy = false,
    after = function()
      -- don't auto restore because i want to always show the dashboard, then
      -- load it myself
      require("nivvie").setup({ autorestore = false })
    end,
  },
}
