local obsidian_workspaces = {
  {
    name = "default",
    path = "~/Documents/obsidian",
  },
  {
    name = "default",
    path = "~/documents/obsidian",
  },
}

local seen = {}
obsidian_workspaces = vim
  .iter(obsidian_workspaces)
  :map(function(workspace)
    local path = vim.uv.fs_realpath(vim.fs.normalize(workspace.path))
    if path and not seen[path] then
      seen[path] = true
      return vim.tbl_extend("force", workspace, { path = path })
    end
  end)
  :totable()

---@type lz.n.PluginSpec[]
return {
  {
    "markview.nvim",
    lazy = false, -- this plugin does its own lazy loading
    after = function()
      local p = require("markview.presets")

      local checkboxes = vim.deepcopy(p.checkboxes.nerd)
      vim.list_extend(checkboxes.custom, {
        { match_string = "@", text = "\u{f1978}", hl = "DiagnosticWarn" },
        { match_string = "s", text = "\u{f040a}", hl = "DiagnosticInfo" },
        { match_string = "d", text = "\u{f03e4}", hl = "Comment" },
        { match_string = "b", text = "\u{f073a}", hl = "DiagnosticError" },
        { match_string = "!", text = "\u{f0238}", hl = "Constant" },
        { match_string = "?", text = "\u{f0625}", hl = "DiagnosticHint" },
      })

      require("markview").setup({
        -- allows us to use hybrid mode
        preview = {
          filetypes = { "markdown", "quarto", "rmd", "typst", "asciidoc", "mdx" },
          modes = { "n", "i", "no", "c" },
          hybrid_modes = { "i" },
          callbacks = {
            on_enable = function(_, win)
              vim.wo[win].conceallevel = 2
              vim.wo[win].concealcursor = "nc"
            end,
          },
        },

        markdown = {
          headings = p.headings.glow,
          checkboxes = checkboxes,
          horizontal_rules = p.horizontal_rules.thin,
          code_blocks = {
            pad_amount = 1,
          },
          list_items = {
            marker_minus = { add_padding = false },
            marker_plus = { add_padding = false },
            marker_star = { add_padding = false },
            marker_dot = { add_padding = false },
          },
        },
      })
    end,
  },

  {
    "obsidian.nvim",
    enabled = #obsidian_workspaces > 0,
    -- setup blocks on the `ob` sync CLI (~100ms), so only pay for it when it's needed
    ft = "markdown",
    cmd = "Obsidian",
    after = function()
      require("obsidian").setup({
        workspaces = obsidian_workspaces,
        legacy_commands = false,
        picker = { name = "fzf-lua" },
        sync = { enabled = true },

        completion = {
          match_case = false,
        },

        checkbox = { order = { " ", "@", "s", "x" } },
      })
    end,
  },

  -- allow me to paste images really easy
  {
    "img-clip.nvim",
    ft = { "markdown" },
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
