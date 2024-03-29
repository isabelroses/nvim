local lsp_present, lspconfig = pcall(require, "lspconfig")

if not lsp_present then
  return
end

local M = {}

M.setup = function(opts)
  lspconfig.jsonls.setup(vim.tbl_extend("keep", {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  }, opts))
  lspconfig.yamlls.setup(vim.tbl_extend("keep", {
    settings = {
      yaml = {
        completion = true,
        validate = true,
        suggest = {
          parentSkeletonSelectedFirst = true,
        },
        schemas = {
          ["https://json.schemastore.org/github-action"] = ".github/action.{yaml,yml}",
          ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*lab-ci.{yaml,yml}",
          ["https://json.schemastore.org/helmfile"] = "helmfile.{yaml,yml}",
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
          ["https://goreleaser.com/static/schema.json"] = ".goreleaser.{yml,yaml}",
        },
      },
      redhat = {
        telemetry = {
          enabled = false,
        },
      },
    },
  }, opts))
end

return M
