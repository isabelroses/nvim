---@type lz.n.PluginSpec[]
return {
  {
    "catppuccin-nvim",
    lazy = false,
    priority = 1200,
    after = function()
      ---@type CatppuccinOptions
      local opts = {
        term_colors = true,
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
        integrations = {
          cmp = false,
          snacks = { enabled = true },
          harpoon = true,
        },
      }

      require("catppuccin").setup(opts)

      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },
}
