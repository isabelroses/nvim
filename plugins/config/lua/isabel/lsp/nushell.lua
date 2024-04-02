local lsp_present, lspconfig = pcall(require, "lspconfig")

if not lsp_present then
  return
end

local M = {}

M.setup = function(opts)
  lspconfig.nushell.setup({
    capabilities = opts.capabilities,
    on_attach = opts.default_on_attach,
  })
end

return M
