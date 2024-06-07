local lsp_present, lspconfig = pcall(require, "lspconfig")

if not lsp_present then
  return
end

local M = {}

M.setup = function(opts)
  lspconfig.lua_ls.setup({
    capabilities = opts.capabilities,
    on_attach = opts.on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })
end

return M
