local lsp_present, lspconfig = pcall(require, "lspconfig")

if not lsp_present then
  return
end

local M = {}

M.setup = function(opts)
  lspconfig.nil_ls.setup({
    capabilities = opts.capabilities,
    cmd = nil,
    on_attach = default_on_attach,
    settings = {
      ["nil"] = {
        formatting = {
          command = { "alejandra", "--quiet" },
        },
        nix = { maxMemoryMB = nil },
      },
    },
  })
end

return M
