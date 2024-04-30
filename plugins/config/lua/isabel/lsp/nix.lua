local lsp_present, lspconfig = pcall(require, "lspconfig")

if not lsp_present then
  return
end

local M = {}

M.setup = function(opts)
  lspconfig.nil_ls.setup({
    capabilities = opts.capabilities,
    cmd = nixd,
    on_attach = opts.default_on_attach,
    settings = {
      ["nixd"] = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "alejandra", "--quiet" },
        },
        options = {
          nixos = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.*.options',
          },
          home_manager = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.*.options',
          },
        },
      },
    },
  })
end

return M
