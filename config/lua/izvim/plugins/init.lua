return {
  -- tree view
  {
    "nvim-tree.lua",
    event = "DeferredUIEnter",
    after = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        diagnostics = { enable = true },
        renderer = {
          indent_markers = { enable = true },
          icons = { web_devicons = { folder = { enable = true } } },
        },
        modified = { enable = true },
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
      return vim.fn.glob("~/.wakatime.cfg") ~= "" or vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= ""
    end,
  },

  {
    "direnv.nvim",
    event = "VimEnter",
    enabled = function()
      return vim.fn.executable("direnv") == 1
    end,
    after = function()
      require("direnv").setup({
        autoload_direnv = true,
      })
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
    "resession.nvim",
    lazy = false,
    after = function()
      local resession = require("resession")
      resession.setup()

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Only load the session if nvim was started with no args and without reading from stdin
          if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
            -- Save these to a different directory, so our manual sessions don't get polluted
            resession.load(vim.fn.getcwd(), { silence_errors = true })
          end
        end,
        nested = true,
      })
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          resession.save(vim.fn.getcwd(), { notify = false })
        end,
      })
      vim.api.nvim_create_autocmd("StdinReadPre", {
        callback = function()
          -- Store this for later
          vim.g.using_stdin = true
        end,
      })
    end,
  },
}
