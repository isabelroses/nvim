local rq = function(plugin)
  return function()
    require("izvim.plugins." .. plugin)
  end
end

return {
  -- tree view
  {
    "nvim-tree",
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
    "mini-surround",
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

  -- markdown stuff
  {
    "markview",
    after = rq("markview"),
  },
  {
    "obsidian-nvim",
    after = rq("obsidian"),
  },

  -- rice
  {
    "alpha",
    after = rq("alpha"),
  },
  {
    "neovim-session-manager",
    priority = 60,
  },

  {
    "lualine",
    after = rq("lualine"),
  },

  {
    "catppuccin",
    priority = 1000,
    event = "UIEnter",
    after = rq("catppuccin"),
  },

  {
    "fidget",
    after = function()
      require("fidget").setup({
        display = { done_icon = "󰗡" },
        notification = {
          override_vim_notify = true,
          window = { winblend = 0 },
        },
        progress = {
          ignore = {
            "copilot",
            "null-ls",
          },
        },
      })
    end,
  },

  {
    "nvim-colorizer",
    after = function()
      require("colorizer").setup({
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          AARRGGBB = false,
          rgb_fn = false,
          hsl_fn = false,
          css = false,
          css_fn = false,
          mode = "background",
          tailwind = "both",
          sass = {
            enable = true,
          },
          virtualtext = " ",
        },

        buftypes = {
          "*",
          "!dashboard",
          "!lazy",
          "!popup",
          "!prompt",
        },
      })
    end,
  },

  {
    "todo-comments",
    after = function()
      require("todo-comments").setup()
    end,
  },

  -- quicker movement
  {
    "telescope",
    after = rq("telescope"),
  },

  {
    "harpoon",
    after = rq("harpoon"),
  },

  -- copilot
  -- copilot-cmp
  {
    "copilot-lua",
    enabled = function()
      return vim.fn.glob("~/.config/gh/config.yml") ~= "" or vim.fn.glob("$XDG_CONFIG_HOME/gh/config.yml") ~= ""
    end,
    event = "InsertEnter",
    after = rq("copilot"),
  },

  -- lsp
  {
    "nvim-treesitter",
    after = rq("tree-sitter"),
  },
  { "rainbow-delimiters" },

  -- rust lsp + formmating
  {
    "rustaceanvim",
    ft = "rust",
    after = rq("rust"),
  },

  {
    "nvim-lspconfig",
    after = rq("lsp"),
  },

  {
    "trouble",
    after = rq("trouble"),
  },
  {
    "lazydev",
    after = function()
      require("lazydev").setup()
    end,
  },

  {
    "crates",
    after = function()
      require("crates").setup({})
    end,
    event = "BufRead Cargo.toml",
  },

  {
    "go-nvim",
    ft = {
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "gohtmltmpl",
      "gotexttmpl",
    },
    after = function()
      -- setup go stuff
      require("go").setup({
        disable_defaults = false,
        icons = {
          breakpoint = " ",
          currentpos = " ",
        },
        trouble = true,
        luasnip = true,
        dap_debug_keymap = false,
        lsp_cfg = false,
        lsp_keymaps = false,
        lsp_inlay_hints = {
          enable = true,
          style = "inlay",
        },
      })

      require("lspconfig").gopls.setup(require("go.lsp").config())
    end,
  },
  { "guihua-lua" },

  -- hide my secrets
  {
    "cloak",
    after = rq("cloak"),
  },

  -- misc
  {
    "undotree",
    after = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },

  -- track my time coding
  {
    "wakatime",
    enabled = function()
      return vim.fn.glob("~/.wakatime.cfg") ~= "" or vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= ""
    end,
  },

  {
    "indent-blankline",
    event = "DeferredUIEnter",
    after = function()
      require("ibl").setup({
        scope = { enabled = false },
        exclude = {
          filetypes = {
            "alpha",
            "fugitive",
            "help",
            "lazy",
            "NvimTree",
            "ToggleTerm",
            "LazyGit",
            "TelescopePrompt",
            "prompt",
            "code-action-menu-menu",
            "code-action-menu-warning-message",
            "Trouble",
          },
        },
      })
    end,
  },

  -- cool snippets saving
  {
    "sayama-nvim",
    after = function()
      require("sayama").setup({
        dir = vim.fn.glob("$XDG_DATA_HOME/zzz"),
      })
    end,
  },

  {
    "freeze",
    after = rq("freeze"),
  },

  -- lazygit integration
  {
    "toggleterm",
    after = function()
      require("toggleterm").setup()

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        float_opts = {
          border = "rounded",
        },
      })

      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<c-t>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
    end,
  },

  {
    "direnv",
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
    after = function()
      require("cord").setup({
        editor = { image = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp" },
        display = { swap_icons = true }, -- place the editor image as the main image
      })
    end,
  },

  -- deps
  {
    "plenary",
    priority = 100,
  },
  {
    "nvim-web-devicons",
    after = rq("nvim-web-devicons"),
  },
}
