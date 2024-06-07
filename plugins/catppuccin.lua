return function()
  require("catppuccin").setup({
    flavour = "auto",
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    styles = {
      comments = { "italic" },
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
      telescope = {
        enabled = true,
      },
      cmp = true,
      lsp_trouble = true,
      nvimtree = {
        enabled = true,
        transparent_panel = true,
      },
      which_key = false,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      navic = {
        enabled = true,
        custom_bg = "NONE",
      },
      gitsigns = false,
      markdown = true,
      harpoon = true,
      symbols_outline = true,
      ts_rainbow = true,
      notify = true,
    },
  })

  vim.cmd.colorscheme("catppuccin")
end
