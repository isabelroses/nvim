return function()
  require("obsidian").setup({
    workspaces = {
      {
        name = "default",
        path = "~/Documents/obsidian",
      },
      {
        name = "default",
        path = "~/documents/obsidian",
      },
      {
        name = "cssuffering",
        path = "~/dev/cssuffering/notes",
      },
    },
    completion = {
      min_chars = 2,
      nvim_cmp = true,
    },
  })
end
