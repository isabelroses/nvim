return function()
  local bc = vim.g.bc

  local no_preview = function(opts)
    local defaults = require("telescope.themes").get_dropdown({
      -- stylua: ignore
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

  local telescope = require("telescope")
  local project_actions = require("telescope._extensions.project.actions")

  telescope.load_extension("fzf")
  telescope.load_extension("notify")
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
      -- stylua: ignore
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
        base_dirs = {
          { "~/dev/aur/", max_depth = 2 },
          { "~/dev/ctp/", max_depth = 1 },
          { "~/dev/cssuffering/", max_depth = 1 },
          { "~/dev/public/", max_depth = 1 },
          { "~/dev/private/", max_depth = 1 },
        },
        on_project_selected = function(prompt_bufnr)
          project_actions.change_working_directory(prompt_bufnr, false)
        end,
      },
    },
  })
end
