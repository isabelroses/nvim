---@type lz.n.PluginSpec[]
return {
  {
    "catppuccin-nvim",
    lazy = false,
    priority = 1200,
    after = function()
      ---@type CatppuccinOptions
      local opts = {
        flavour = "auto",
        background = {
          light = "latte",
          dark = "mocha",
        },
        term_colors = true,
        transparent_background = false,
        -- color_overrides = {
        --   mocha = {
        --     base = "#000000",
        --     mantle = "#000000",
        --     crust = "#000000",
        --   },
        -- },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        integrations = {
          treesitter = true,
          treesitter_context = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          cmp = false,
          blink_cmp = true,
          lsp_trouble = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          navic = {
            enabled = true,
            custom_bg = "NONE",
          },
          gitsigns = true,
          markdown = true,
          harpoon = true,
        },
      }

      require("catppuccin").setup(opts)

      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },
}
