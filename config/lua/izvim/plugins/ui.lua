---@type lz.n.PluginSpec[]
return {
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = {
        default = "",
        n = "",
        i = "󰗧",
        v = "󰫙",
        c = "",
      }

      local config = {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = "",
          section_separators = "",
          disabled_filetypes = { statusline = { "snacks_dashboard", "dashboard", "alpha", "ministarter" } },
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                local mode = vim.api.nvim_get_mode().mode:sub(0, 1)
                local icon = icons[mode] or icons.default
                return icon .. " " .. str
              end,
            },
          },
          lualine_b = {
            { "branch", icon = "" },
            "diff",
          },
          lualine_c = { "diagnostics", "searchcount" },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        tabline = {},
        winbar = {
          lualine_c = { "navic" },
          lualine_x = {
            {
              function()
                return "  "
              end,
              cond = function()
                local present, navic = pcall(require, "nvim-navic")
                if not present then
                  return false
                end
                return navic.is_available()
              end,
            },
          },
        },
        inactive_winbar = {},
        extensions = {},
      }

      require("lualine").setup(config)
    end,
  },

  {
    "fidget.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("fidget").setup({
        notification = {
          window = { normal_hl = "MsgArea", winblend = 100 },
        },
        progress = {
          display = { done_icon = "󰗡" },
          ignore = {
            "null-ls",
          },
        },
      })
    end,
  },

  {
    "indent-blankline.nvim",
    event = "DeferredUIEnter",
    after = function()
      ---@type ibl.config
      local opts = {
        scope = { enabled = false },
        exclude = {
          filetypes = {
            "help",
            "neo-tree",
            "ToggleTerm",
            "LazyGit",
            "prompt",
            "Trouble",
            "snacks_dashboard",
          },
        },
      }

      require("ibl").setup(opts)
    end,
  },

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

  -- highlight TODO, FIXME, etc.
  {
    "todo-comments.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("todo-comments").setup()
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
