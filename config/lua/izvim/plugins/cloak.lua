-- hide my secrets
---@type lz.n.PluginSpec[]
return {
  {
    "cloak.nvim",
    event = "BufAdd",
    after = function()
      require("cloak").setup({
        patterns = {
          {
            file_pattern = {
              ".env",
              ".env.local",
              ".env.dev",
              ".env.development",
              "wrangler.toml",
              ".dev.vars",
              "secrets.yaml",
              "secrets.yml",
              "*.age",
            },
            cloak_pattern = { ":.+", "=.+" },
          },
        },
      })
    end,
  },
}
