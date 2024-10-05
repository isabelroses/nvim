return function()
  local p = require("markview.presets")

  require("markview").setup({
    -- allows us to use hybrid mode
    modes = { "n", "i", "no", "c" },
    hybrid_modes = { "i" },
    callbacks = {
      on_enable = function(_, win)
        vim.wo[win].conceallevel = 2
        vim.wo[win].concealcursor = "nc"
      end,
    },

    headings = p.headings.glow,
    checkboxes = p.checkboxes.nerd,
    horizontal_rules = p.horizontal_rules.thin,
    code_blocks = {
      pad_amount = 1,
    },
    list_items = {
      -- indent_size = 0,
      marker_minus = { add_padding = false },
      marker_plus = { add_padding = false },
      marker_star = { add_padding = false },
      marker_dot = { add_padding = false },
    },
  })
end
