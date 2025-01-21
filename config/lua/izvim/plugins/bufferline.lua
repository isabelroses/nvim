return {
  {
    "bufferline.nvim",
    event = "DeferredUIEnter",
    after = function()
      local bufferline = require("bufferline")
      local ctp = require("catppuccin.groups.integrations.bufferline").get()

      bufferline.setup({
        highlights = ctp,
        options = {
          show_close_icon = false,
          show_buffer_close_icons = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Browser",
              text_align = "left",
              separator = vim.g.bc.vert,
            },
          },
          left_mouse_command = "buffer %d",
          middle_mouse_command = "bdelete! %d",
          right_mouse_command = nil,
          numbers = "ordinal",
        },
      })
    end,
  },
}
