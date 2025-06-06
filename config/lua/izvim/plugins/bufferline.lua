return {
  {
    "bufferline.nvim",
    event = "DeferredUIEnter",
    after = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("bufferline:setup", { clear = true }),
        callback = function(ev)
          local bufferline = require("bufferline")

          local opts = {
            options = {
              show_close_icon = false,
              show_buffer_close_icons = false,
              show_buffer_icons = false,
              offsets = {
                {
                  filetype = "NvimTree",
                  text = "File Browser",
                  text_align = "center",
                  separator = "",
                },
              },
              left_mouse_command = "buffer %d",
              middle_mouse_command = "bdelete! %d",
              right_mouse_command = nil,
              mode = "buffers",
              numbers = "none",
              indicator = {
                style = "icon",
                icon = "",
              },
              style = "none",
              diagnostics = false,
            },
          }

          local colorscheme = ev.data.colorscheme or ev.match or ""

          if (colorscheme):match("catppuccin") then
            bufferline.setup(vim.tbl_deep_extend("force", opts, {
              highlights = require("catppuccin.groups.integrations.bufferline").get(),
            }))
          elseif (colorscheme):match("cuddlefish") then
            local colours = require("cuddlefish.colors").get()
            local highlights = {
              buffer_selected = { fg = colours.base, bg = colours.purple, italic = false },
            }

            bufferline.setup(vim.tbl_deep_extend("force", opts, {
              highlights = highlights,
            }))
          else
            bufferline.setup(opts)
          end
        end,
      })
      vim.api.nvim_exec_autocmds("ColorScheme", { data = { colorscheme = vim.g.colors_name } })
    end,
  },
}
