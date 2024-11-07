return {
  -- we set these to lazy as we use another plugin to load them
  { "telescope-project.nvim", lazy = false },
  { "telescope-fzf-native.nvim", lazy = false },
  { "telescope-ui-select.nvim", lazy = false },

  {
    "telescope.nvim",
    event = "DeferredUIEnter",
    after = function()
      -- so quircky but we need to load this before telescope
      local exts = {
        "project",
        "ui-select",
        "fzf-native",
      }

      -- trigger the load of all the extensions we use
      for _, ext in ipairs(exts) do
        require("lz.n").trigger_load({ "telescope-" .. ext .. ".nvim" })
      end

      local bc = vim.g.bc

      local no_preview = function(opts)
        local defaults = require("telescope.themes").get_dropdown({
          borderchars = {
            { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
            prompt = { bc.horiz, bc.vert, " ", bc.vert, bc.topleft, bc.topright, bc.vert, bc.vert },
            results = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.vertright, bc.vertleft, bc.botright, bc.botleft },
            preview = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
          },
          width = 0.8,
          previewer = false,
          prompt_title = false,
          results_title = false,
        })
        return vim.tbl_deep_extend("keep", opts or {}, defaults)
      end

      local project_actions = require("telescope._extensions.project.actions")
      local telescope = require("telescope")

      telescope.load_extension("fzf")
      telescope.load_extension("project")
      telescope.load_extension("ui-select")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          multi_icon = "│",
          file_ignore_patterns = {
            "%.npz",
            "%.pyc",
            "%.luac",
            "%.ipynb",
            "vendor/*",
            "%.lock",
            "__pycache__/*",
            "%.sqlite3",
            "%.ipynb",
            "node_modules/*",
            "%.min.js",
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.age",
            "%.svg",
            "%.otf",
            "%.ttf",
            "\\.git/",
            "%.webp",
            "\\.dart_tool/",
            "\\.gradle/",
            "\\.idea/",
            "\\.settings/",
            "\\.vscode/",
            "__pycache__/",
            "build/",
            "env/",
            "gradle/",
            "node_modules/",
            "target/",
            "%.pdb",
            "%.dll",
            "%.class",
            "%.exe",
            "%.so",
            "%.cache",
            "%.ico",
            "%.pdf",
            "%.dylib",
            "%.jar",
            "%.docx",
            "%.met",
            "smalljre_*/*",
            "\\.vale/",
            "_sources/",
            "tmp/",
          },
          borderchars = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
        },
        pickers = {
          find_files = no_preview(),
          live_grep = no_preview({
            previewer = true,
          }),
          load_session = no_preview(),
        },
        extensions = {
          ["ui-select"] = no_preview(),
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          project = {
            search_by = { "path", "title" },
            hidden_files = true, -- default: false
            sync_with_nvim_tree = true, -- default false
            on_project_selected = function(prompt_bufnr)
              project_actions.change_working_directory(prompt_bufnr, false)
            end,
          },
        },
      })

      local map = function(mode, shortcut, command, opt)
        opt = opt or { noremap = true, silent = true }
        vim.keymap.set(mode, shortcut, command, opt)
      end

      map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>") -- find files
      map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- grep through all files
      map("n", "<leader>fs", "<cmd>SessionManager load_session<cr>") -- Show nvim sessions
      -- map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- search help tags
      map("n", "<leader>fp", "<cmd>Telescope project<cr>") -- skip to project
      map("n", "<leader>ft", "<cmd>TodoTelescope<cr>") -- live grep but for TODOs and FIXMEs
      map("n", "<leader>fc", "<cmd>Telescope git_commits<cr>") -- git commits
      map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>") -- fuzzy find in current buffer
    end,
  },
}
