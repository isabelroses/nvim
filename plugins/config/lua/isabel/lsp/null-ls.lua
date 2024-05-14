local null_present, null = pcall(require, "null-ls")

if not null_present then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  null.builtins.formatting.nixfmt,
  null.builtins.formatting.dfmt,
  null.builtins.formatting.gofumpt,
  null.builtins.formatting.prettier.with({
    filetypes = {
      "html",
      "astro",
      "vue",
    },
  }),
  null.builtins.formatting.shfmt,
  null.builtins.formatting.stylua,
  null.builtins.diagnostics.alex,
  null.builtins.diagnostics.proselint,
}

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
