vim.g.rustaceanvim = {
  on_attach = function(client, bufnr)
    -- register which-key mappings
    local wk = require("which-key")
    wk.register({
      ["<leader>cR"] = {
        function()
          vim.cmd.RustLsp("codeAction")
        end,
        "Code Action",
      },
      ["<leader>dr"] = {
        function()
          vim.cmd.RustLsp("debuggables")
        end,
        "Rust debuggables",
      },
    }, { mode = "n", buffer = bufnr })
  end,
  settings = {
    -- rust-analyzer language server configuration
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      -- Add clippy lints for Rust.
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
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
}
