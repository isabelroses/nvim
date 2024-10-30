return {
  {
    "markview.nvim",
    lazy = false, -- this plugin does its own lazy loading
    after = function()
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
    end,
  },

  {
    "obsidian.nvim",
    after = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "default",
            path = "~/Documents/obsidian",
          },
          {
            name = "default",
            path = "~/documents/obsidian",
          },
          {
            name = "cssuffering",
            path = "~/dev/cssuffering/notes",
          },
        },
      })
    end,
  },

  -- allow me to paste images really easy
  {
    "img-clip.nvim",
    after = function()
      require("img-clip").setup({
        filetypes = {
          markdown = {
            template = function()
              local root_dir = vim.fs.find({ ".obsidian" }, { upward = true })
              if vim.tbl_isempty(root_dir) then
                return "![$CURSOR]($FILE_PATH)"
              else
                return "![[$FILE_PATH]]"
              end
            end,
          },
        },
      })
    end,
  },
}
