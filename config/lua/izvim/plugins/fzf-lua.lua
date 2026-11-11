---@type lz.n.PluginSpec[]
return {
  {
    "fzf-lua",
    event = "DeferredUIEnter",
    after = function()
      -- fd/rg skip ignored paths while walking the tree
      local defaults = require("fzf-lua.defaults").defaults
      local ignore = " --ignore-file " .. vim.fn.shellescape(vim.g.izvim_search_ignore)

      require("fzf-lua").setup({
        "telescope",
        winopts = function(opts)
          opts = opts or {}
          return {
            backdrop = 100,
            width = math.floor(math.min(vim.o.columns - 4, (opts.previewer and 0.8 or 0.6) * vim.o.columns)),
          }
        end,
        fzf_opts = {
          ["--layout"] = "reverse-list",
          ["--info"] = "inline-right",
          ["--no-separator"] = "",
        },
        file_icon_padding = " ",
        prompt = " ",
        previewer = "builtin",
        files = {
          fd_opts = defaults.files.fd_opts .. ignore,
          rg_opts = defaults.files.rg_opts .. ignore,
          cwd_prompt = false,
          previewer = false,
          git_icons = false,
        },
        grep = {
          -- `-e` has to stay last, it takes the search pattern
          rg_opts = defaults.grep.rg_opts:gsub("%-e$", "") .. ignore .. " -e",
        },
        grep_curbuf = {
          winopts = {
            treesitter = true,
          },
        },
      })

      require("fzf-lua").register_ui_select()

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
      end

      map("<leader><leader>", "<cmd>FzfLua files<cr>", "find files")
      map("<leader>fg", "<cmd>FzfLua live_grep<cr>", "grep through all files")
      map("<leader>fh", "<cmd>FzfLua help_tags<cr>", "search help tags")
      map("<leader>fz", "<cmd>FzfLua zoxide<cr>", "list recent dirs")
    end,
  },

  -- project-wide find & replace (fzf greps, but can't replace)
  {
    "grug-far.nvim",
    keys = {
      {
        "<leader>fr",
        function()
          require("grug-far").open()
        end,
        desc = "search and replace",
      },
    },
    after = function()
      require("grug-far").setup({})
    end,
  },
}
