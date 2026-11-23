---@type lz.n.PluginSpec[]
return {
  {
    "mini.surround",
    event = "InsertEnter",
    after = function()
      require("mini.surround").setup({
        mappings = {
          add = "S",
          delete = "ds",
          replace = "cs",
          update_n_lines = "",
          suffix_last = "",
          suffix_next = "",
        },
      })
    end,
  },

  {
    "flash.nvim",
    event = "DeferredUIEnter",
    after = function()
      local flash = require("flash")
      flash.setup()

      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc })
      end
      map({ "n", "x", "o" }, "s", flash.jump, "flash")
      map({ "n", "x", "o" }, "gs", flash.treesitter, "flash treesitter node")
      map("o", "r", flash.remote, "remote flash")
      map({ "o", "x" }, "R", flash.treesitter_search, "treesitter search")
      map("c", "<c-s>", flash.toggle, "toggle flash in / search")
    end,
  },

  {
    -- lmao
    "harpoon2",
    event = "DeferredUIEnter",
    after = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>d", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)

      -- harpoon lists are 1-indexed
      for i = 1, 4 do
        vim.keymap.set("n", "<leader>" .. i, function()
          harpoon:list():select(i)
        end)
      end
    end,
  },

  -- hide my secrets
  {
    "cloak.nvim",
    event = "BufAdd",
    after = function()
      require("cloak").setup({
        patterns = {
          {
            file_pattern = {
              ".env",
              ".env.local",
              ".env.dev",
              ".env.development",
              "wrangler.toml",
              ".dev.vars",
              "secrets.yaml",
              "secrets.yml",
              "*.age",
            },
            cloak_pattern = { ":.+", "=.+" },
          },
        },
      })
    end,
  },
}
