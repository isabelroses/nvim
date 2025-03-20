return {
  {
    "bufferline.nvim",
    event = "DeferredUIEnter",
    after = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("bufferline:setup", { clear = true }),
        callback = function(ev)
          local bufferline = require("bufferline")
          local ctp = require("catppuccin.groups.integrations.bufferline").get()

          local opts = {
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
          }

          local colorscheme = ev.match or ""

          if (colorscheme):match("catppuccin") then
            bufferline.setup(vim.tbl_deep_extend("force", opts, {
              highlights = ctp,
            }))
          else
            bufferline.setup(opts)
          end
        end,
      })
      vim.api.nvim_exec_autocmds("ColorScheme", {})
    end,
  },
}
