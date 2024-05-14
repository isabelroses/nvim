local lsp_present, lspconfig = pcall(require, "lspconfig")

if not lsp_present then
  return
end

local M = {}

M.setup = function(opts)
  lspconfig.nixd.setup({
    capabilities = opts.capabilities,
    cmd = { "nixd" },
    on_attach = opts.default_on_attach,
    settings = {
      ["nixd"] = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "nixfmt" },
        },
        options = {
          nixos = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.${let s = builtins.readFile /etc/hostname; in builtins.substring 0 ((builtins.stringLength s) - 1) s}.options',
          },
          darwin = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).darwinConfigurations.${let s = builtins.readFile /etc/hostname; in builtins.substring 0 ((builtins.stringLength s) - 1) s}.options',
          },
          -- home_manager = {
          --   expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.hydra.options',
          -- },
          flake_parts = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).currentSystem.options',
          },
        },
      },
    },
  })
end

return M
