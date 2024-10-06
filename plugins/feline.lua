return function()
  require("feline").setup({
    vi_mode_colors = {
      NORMAL = "bg_green",
      INSERT = "bg_blue",
      VISUAL = "bg_purple",
      OPERATOR = "bg_purple",
      REPLACE = "bg_red",
      COMMAND = "bg_yellow",
    },
    components = {
      active = {
        {
          {
            provider = "vi_mode",
            hl = {
              bg = require("feline.providers.vi_mode").get_mode_color(),
              fg = "black",
            },
          },
          { provider = "git_branch" },
          { provider = "git_diff_added" },
          { provider = "git_diff_removed" },
          { provider = "git_diff_changed" },
          { provider = "diagnostic_errors" },
          { provider = "diagnostic_warnings" },
          { provider = "diagnostic_hints" },
          { provider = "diagnostic_info" },
          { provider = "search_count" },
        },
        {},
        {
          { provider = "file_type" },
          { provider = "line_percentage" },
          { provider = "position" },
        },
      },
    },
  })

  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      require("feline").use_theme(vim.g.colors_name)
    end,
    desc = "update feline theme",
  })
end
