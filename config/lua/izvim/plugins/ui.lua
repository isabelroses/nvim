---@type lz.n.PluginSpec[]
return {
  {
    "catppuccin-nvim",
    lazy = false,
    priority = 1200,
    after = function()
      require("catppuccin").setup({
        term_colors = true,
        color_overrides = {
          mocha = { base = "#000000", mantle = "#000000", crust = "#000000" },
        },
        integrations = {
          cmp = false,
          snacks = { enabled = true },
          harpoon = true,
        },
      })
      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },

  {
    "mini.icons",
    lazy = false,
    priority = 100,
    after = function()
      require("mini.icons").setup({
        file = {
          [".ecrc"] = { glyph = "", hl = "MiniIconsGreen" },
          [".envrc"] = { glyph = "", hl = "MiniIconsYellow" },
          [".editorconfig"] = { glyph = "", hl = "MiniIconsGreen" },
          [".luacheckrc"] = { glyph = "󰢱", hl = "MiniIconsBlue" },
        },
      })
    end,
  },

  {
    "bufferline.nvim",
    event = "DeferredUIEnter",
    after = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("bufferline:setup", { clear = true }),
        callback = function(ev)
          local bufferline = require("bufferline")

          ---@type bufferline.UserConfig
          local opts = {
            options = {
              show_close_icon = false,
              show_buffer_close_icons = false,
              show_buffer_icons = false,
              offsets = {
                { filetype = "snacks_layout_box", text = "File Browser", text_align = "center", separator = "" },
              },
              middle_mouse_command = "bdelete! %d",
              indicator = { icon = "" },
            },
          }

          local colorscheme = ev.data.colorscheme or ev.match or ""
          if colorscheme:match("catppuccin") then
            opts.highlights = require("catppuccin.special.bufferline").get_theme()
          end
          bufferline.setup(opts)
        end,
      })
      vim.api.nvim_exec_autocmds("ColorScheme", { data = { colorscheme = vim.g.colors_name } })
    end,
  },

  {
    "nvim-colorizer.lua",
    event = "DeferredUIEnter",
    after = function()
      require("colorizer").setup({
        -- RGB, RRGGBB, AARRGGBB and css look like defaults but aren't once user options are given
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          AARRGGBB = false,
          css = false,
          tailwind = "both",
          sass = { enable = true, parsers = { css = true } },
          virtualtext = " ",
        },

        buftypes = { "*", "!dashboard", "!lazy", "!popup", "!prompt" },
      })
    end,
  },

  { "rainbow-delimiters.nvim" },

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

  {
    "smear-cursor.nvim",
    enabled = not vim.g.neovide,
    event = "DeferredUIEnter",
    after = function()
      require("smear_cursor").setup({
        stiffness = 0.8,
        trailing_stiffness = 0.5,
        distance_stop_animating = 0.5,
      })
    end,
  },

  {
    "mini.animate",
    event = "DeferredUIEnter",
    after = function()
      require("mini.animate").setup({
        cursor = { enable = false },
        scroll = { enable = false },
      })
    end,
  },

  {
    "tiny-glimmer.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("tiny-glimmer").setup()
    end,
  },
}
