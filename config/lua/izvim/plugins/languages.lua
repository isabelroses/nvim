---@type lz.n.PluginSpec[]
return {
  {
    "rustaceanvim",
    lazy = false,
    after = function()
      local keys = {
        { "<leader>cR", "codeAction", "rust code action" },
        { "<leader>dr", "debuggables", "rust debuggables" },
        { "<leader>rr", "runnables", "rust runnables" },
        { "<leader>rt", "testables", "rust testables" },
        { "<leader>re", "expandMacro", "expand macro" },
        { "<leader>rc", "openCargo", "open Cargo.toml" },
        { "<leader>rp", "parentModule", "parent module" },
      }

      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            for _, key in ipairs(keys) do
              vim.keymap.set("n", key[1], function()
                vim.cmd.RustLsp(key[2])
              end, { buffer = bufnr, desc = key[3] })
            end
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true, loadOutDirsFromCheck = true, runBuildScripts = true },
              checkOnSave = { allFeatures = true, command = "clippy", extraArgs = { "--no-deps" } },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      }
    end,
  },

  {
    "crates.nvim",
    after = function()
      require("crates").setup({})
    end,
    event = "BufRead Cargo.toml",
  },

  {
    "typst-preview-nvim",
    ft = "typst",
    after = function()
      -- don't call setup since it does binary stuff SIGHHHHH
      require("typst-preview.commands").create_commands()
    end,
  },
}
