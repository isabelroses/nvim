---@type lz.n.PluginSpec[]
return {
  {
    "gitsigns.nvim",
    event = "BufReadPost",
    after = function()
      require("gitsigns").setup()
    end,
  },
}
