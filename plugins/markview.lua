return function()
  require("markview").setup({
    headings = {
      shift_width = 0,
    },
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
