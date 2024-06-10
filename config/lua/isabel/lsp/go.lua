require("go").setup({
  disable_defaults = false,
  icons = {
    breakpoint = " ",
    currentpos = " ",
  },
  trouble = true,
  luasnip = true,
  dap_debug_keymap = false,
  lsp_cfg = false,
  lsp_keymaps = false,
  lsp_inlay_hints = {
    enable = true,
    -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
    -- inlay only avalible for 0.10.x
    style = "eol",
  },
})

require("lspconfig").gopls.setup(require("go.lsp").config())
