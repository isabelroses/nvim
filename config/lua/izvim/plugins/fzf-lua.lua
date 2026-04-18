return {
  {
    "fzf-lua",
    event = "DeferredUIEnter",
    after = function()
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
          cwd_prompt = false,
          previewer = false,
          git_icons = false,
        },
        grep_curbuf = {
          winopts = {
            treesitter = true,
          },
        },
        file_ignore_patterns = {
          -- keep-sorted start
          "%.age",
          "%.cache",
          "%.class",
          "%.dart_tool/",
          "%.dll",
          "%.docx",
          "%.dylib",
          "%.exe",
          "%.git/",
          "%.gradle/",
          "%.ico",
          "%.idea/",
          "%.ipynb",
          "%.jar",
          "%.jpeg",
          "%.jpg",
          "%.lock",
          "%.luac",
          "%.met",
          "%.min.js",
          "%.npz",
          "%.otf",
          "%.pdb",
          "%.pdf",
          "%.png",
          "%.pyc",
          "%.settings/",
          "%.so",
          "%.sqlite3",
          "%.ttf",
          "%.vale/",
          "%.vscode/",
          "%.webp",
          ".direnv/",
          ".direnv/*",
          "__pycache__/",
          "__pycache__/*",
          "_sources/",
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
          "node_modules/*",
          "smalljre_*/*",
          "target/",
          "tmp/",
          "vendor/*",
          -- keep-sorted end
        },
      })

      require("fzf-lua").register_ui_select()

      local map = function(mode, shortcut, command, opt)
        opt = opt or { noremap = true, silent = true }
        vim.keymap.set(mode, shortcut, command, opt)
      end

      map("n", "<leader><leader>", "<cmd>FzfLua files<cr>") -- find files
      map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>") -- grep through all files
      map("n", "<leader>fs", "<cmd>SessionManager load_session<cr>") -- Show nvim sessions
      map("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>") -- search help tags
      map("n", "<leader>ft", "<cmd>TodoFzfLua<cr>") -- live grep but for TODOs and FIXMEs
      map("n", "<leader>fz", "<cmd>FzfLua zoxide<cr>") -- list recent dirs
    end,
  },
}
