return {
  {
    "copilot.lua",
    enabled = function()
      return vim.fn.glob("$XDG_CONFIG_HOME/gh/config.yml") ~= "" or vim.fn.glob("~/.config/gh/config.yml") ~= ""
    end,
    event = "InsertEnter",
    after = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<C-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-a>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = false,
          },
        },
        filetypes = {
          ["*"] = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        server_opts_overrides = {},
        server = {
          type = "binary",
          custom_server_filepath = vim.fn.exepath("copilot-language-server"),
        },
      })
    end,
  },
}
