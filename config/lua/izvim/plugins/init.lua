return {
  -- tree view
  {
    "neo-tree.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("lz.n").trigger_load("nui.nvim")
      require("neo-tree").setup({
        popup_border_style = "", -- use 'winborder'
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
          },
          use_libuv_file_watcher = true,
        },
        default_component_configs = {
          icon = {
            provider = function(icon, node) -- setup a custom icon provider
              local text, hl
              local mini_icons = require("mini.icons")
              if node.type == "file" then -- if it's a file, set the text/hl
                text, hl = mini_icons.get("file", node.name)
              elseif node.type == "directory" then -- get directory icons
                text, hl = mini_icons.get("directory", node.name)
                -- only set the icon text if it is not expanded
                if node:is_expanded() then
                  text = nil
                end
              end

              -- set the icon text/highlight only if it exists
              if text then
                icon.text = text
              end
              if hl then
                icon.highlight = hl
              end
            end,
          },
          kind_icon = {
            provider = function(icon, node)
              local mini_icons = require("mini.icons")
              icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
            end,
          },
        },
      })

      vim.keymap.set(
        "n",
        "<Plug>(neotree-toggle)",
        "<cmd>Neotree toggle action=show left<cr>",
        { desc = "open tree view" }
      )

      vim.api.nvim_create_autocmd("WinEnter", {
        pattern = "neo-tree *",
        group = vim.api.nvim_create_augroup("filetype:neo-tree:options", { clear = true }),
        callback = function(ev)
          vim.api.nvim_set_option_value("sidescrolloff", 0, { win = ev.win })
        end,
      })
    end,
  },

  -- mini
  {
    "mini.surround",
    event = "InsertEnter",
    after = function()
      require("mini.surround").setup({
        mappings = {
          add = "S", -- Add surrounding in Normal and Visual modes
          delete = "ds", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "cs", -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`
          suffix_last = "", -- Suffix to search with "prev" method
          suffix_next = "", -- Suffix to search with "next" method
        },
      })
    end,
  },

  -- add better undo history
  {
    "undotree",
    event = "BufReadPost",
    after = function()
      require("undotree").setup()
      vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
    end,
  },

  -- track my time coding
  {
    "vim-wakatime",
    event = "VimEnter",
    enabled = function()
      return vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= "" or vim.fn.glob("~/.wakatime.cfg") ~= ""
    end,
  },

  -- discord integration
  {
    "cord.nvim",
    event = "VimEnter",
    after = function()
      require("cord").setup({
        editor = { icon = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp" },
        display = { swap_icons = true },
      })
    end,
  },

  {
    "gitsigns.nvim",
    event = "BufReadPost",
    after = function()
      require("gitsigns").setup()
    end,
  },

  {
    "nivvie-nvim",
    lazy = false,
  },

  {
    "nui.nvim",
  },
}
