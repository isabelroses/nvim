local null_present, null = pcall(require, "null-ls")

if not null_present then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  null.builtins.formatting.alejandra,
  null.builtins.formatting.dfmt,
  -- null.builtins.formatting.deno_fmt.with({
  -- 	filetypes = {
  -- 		"javascript",
  -- 		"javascriptreact",
  -- 		"typescript",
  -- 		"typescriptreact",
  -- 	},
  -- }),
  null.builtins.formatting.gofumpt,
  null.builtins.diagnostics.revive,
  null.builtins.formatting.prettier.with({
    filetypes = {
      "html",
      "astro",
      "vue",
    },
  }),
  -- null.builtins.formatting.ruff,
  -- null.builtins.formatting.rustfmt,
  null.builtins.formatting.shfmt,
  null.builtins.formatting.stylua,
  -- null.builtins.formatting.taplo,
  null.builtins.diagnostics.statix,
  null.builtins.diagnostics.deadnix,
  null.builtins.diagnostics.alex,
  null.builtins.diagnostics.proselint,
}

-- local golangci_lint = require("go.null_ls").golangci_lint()
local gotest = require("go.null_ls").gotest()
local gotest_codeaction = require("go.null_ls").gotest_action()
table.insert(sources, gotest)
-- table.insert(sources, golangci_lint)
table.insert(sources, gotest_codeaction)

null.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c)
              return c.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})

local toggle_formatters = function()
  null.toggle({ methods = null.methods.FORMATTING })
end

vim.api.nvim_create_user_command("ToggleFormatters", toggle_formatters, {})
