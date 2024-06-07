vim.g.rustaceanvim = {
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<leader>cR", function()
      vim.cmd.RustLsp("codeAction")
    end)
    vim.keymap.set("n", "<leader>dr", function()
      vim.cmd.RustLsp("debuggables")
    end, { buffer = bufnr })
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
