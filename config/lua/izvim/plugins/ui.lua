---@type lz.n.PluginSpec[]
return {
  {
    "mini.icons",
    lazy = false,
    priority = 100,
    after = function()
      require("mini.icons").setup({
        file = {
          [".ecrc"] = {
            glyph = "",
            hl = "MiniIconsGreen",
          },
          [".envrc"] = {
            glyph = "",
            hl = "MiniIconsYellow",
          },
          [".editorconfig"] = {
            glyph = "",
            hl = "MiniIconsGreen",
          },
          [".luacheckrc"] = {
            glyph = "󰢱",
            hl = "MiniIconsBlue",
          },
        },
      })
    end,
  },

  {
    "nvim-colorizer.lua",
    event = "DeferredUIEnter",
    after = function()
      require("colorizer").setup({
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          AARRGGBB = false,
          rgb_fn = false,
          hsl_fn = false,
          css = false,
          css_fn = false,
          mode = "background",
          tailwind = "both",
          sass = {
            enable = true,
            parsers = { css = true },
          },
          virtualtext = " ",
        },

        buftypes = {
          "*",
          "!dashboard",
          "!lazy",
          "!popup",
          "!prompt",
        },
      })
    end,
  },

  -- breadcrumbs in the winbar
  {
    "dropbar.nvim",
    event = "DeferredUIEnter", -- attaches to already open windows when it loads
    after = function()
      require("dropbar").setup()
      vim.keymap.set("n", "<leader>;", function()
        require("dropbar.api").pick()
      end, { desc = "pick a winbar symbol" })
    end,
  },

  -- sticky scroll: keep the enclosing function/class header pinned at the top
  {
    "nvim-treesitter-context",
    event = "DeferredUIEnter",
    after = function()
      require("treesitter-context").setup({
        max_lines = 1,
        multiline_threshold = 1,
      })
    end,
  },
}
