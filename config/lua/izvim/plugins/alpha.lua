return {
  {
    "resession.nvim",
    after = function()
      local resession = require("resession")
      resession.setup()

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Only load the session if nvim was started with no args and without reading from stdin
          if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
            local dir = vim.fn.getcwd()

            if not vim.iter(resession.list()):find(dir:gsub("/", "_")) then
              return
            end

            -- Save these to a different directory, so our manual sessions don't get polluted
            resession.load(dir, { silence_errors = true })
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

  {
    "alpha-nvim",
    lazy = false,
    after = function()
      require("lz.n").trigger_load({ "resession.nvim" })

      local function apply_gradient_hl(text)
        local lines = {}
        for i, line in ipairs(text) do
          local tbl = {
            type = "text",
            val = line,
            opts = {
              hl = "AlphaHeaderGradient" .. i,
              shrink_margin = false,
              position = "center",
            },
          }
          table.insert(lines, tbl)
        end

        return {
          type = "group",
          val = lines,
          opts = { position = "center" },
        }
      end

      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local theta = require("alpha.themes.theta")

      local header = {
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⢸⣿⣿⣿⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⡿⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠘⣿⣿⠇⠀⠀⡀⠈⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⠀⠀⠈⠙⢿⣿⣿⣿⣿⣿⡿⠛⠒⢊⠁⢰⣿⠏⠀⠀⠀⠈⠁⢒⠂⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⢻⣿⣿⡿⠋⠀⠀⠘⠿⠇⣼⠏⠀⠀⠀⠀⠀⠘⠿⠃⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠹⣿⡁⠀⠀⠀⠀⠀⠀⠋⠀⠀⡀⠀⠀⠀⠀⠀⠀⠐⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⠀⠀⠙⠇⠀⠀⢠⣶⣤⡄⠀⠀⠀⠉⢶⢀⣰⠆⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⣸⢸⢺⢱⠀⠀⠀⠀⣸⠬⠵⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣭⠀⠀⠀⠲⣻⡘⠘⠀⢦⠀⠀⠔⠁⠀⠀⣀⠤⠚⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⠛⢷⣤⡀⠀⢘⣗⠀⠀⠀⠱⣤⣴⣖⠈⠹⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⠟⠋⠙⠻⣿⣿⣿⣿⣿⣷⣦⣬⠃⣴⣿⣽⣷⣄⣀⢀⣿⣿⡿⠷⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⠃⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⡇⠀⢹⡿⠿⣍⡙⠛⠛⣻⠟⠻⠶⠦⣤⠞⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣿⣧⣀⠞⠀⠀⠉⠛⠛⠛⢿⠀⠀⠀⠀⠀⠀⢘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⡎⠀⠀⠀⢀⡀⠤⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⢨⠃⠀⠀⠀⠀⠀⠀⠀⠀⡸⠀⠀⡠⠒⠉⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⣠⠃⠀⠀⠀⠀⠀⠀⠀⠀⡰⢁⠔⠋⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⣼⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠞⠁⠀⠀⠀⠀⠀⠀⠀⢀⡆⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⡀⠀⠀⠀⠀⠀⢀⡰⠃⠀⠀⠀⠀⠀⠀⠀⣀⣴⣿⣿⡀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿",
      }

      local buttons = {
        type = "group",
        position = "center",
        val = {
          dashboard.button("n", "  New file", ":ene <bar> startinsert <cr>"),
          dashboard.button("f", "  Find file", ":Telescope find_files<cr>"),
          dashboard.button("g", "  Live grep", ":Telescope live_grep<cr>"),
          dashboard.button("s", "  Show sessions", ":SessionManager load_session<cr>"),
          dashboard.button("p", "  Projects", ":Telescope project<CR>"),
          dashboard.button("q", "  Quit", ":qa<CR>"),
        },
      }

      local v = vim.version()
      local vStr = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

      local footer = {
        type = "group",
        position = "center",
        val = {
          {
            type = "text",
            val = "neovim " .. vStr,
            opts = { hl = "Comment", position = "center" },
          },
        },
      }

      if vim.g.neovide then
        table.insert(footer.val, 2, {
          type = "text",
          val = "neovide v" .. vim.g.neovide_version,
          opts = { hl = "Comment", position = "center" },
        })
      end

      theta.config.layout = {
        { type = "padding", val = 4 },
        apply_gradient_hl(header),
        { type = "padding", val = 1 },
        buttons,
        { type = "padding", val = 1 },
        footer,
      }

      alpha.setup(theta.config)
    end,
  },
}
