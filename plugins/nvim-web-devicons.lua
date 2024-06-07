return function()
  local C = require("catppuccin.palettes").get_palette()

  local justfile = {
    icon = "󱚣",
    name = "Justfile",
    color = C.peach,
  }

  require("tiny-devicons-auto-colors").setup({
    colors = C,
  })

  require("nvim-web-devicons").setup({
    override_by_filename = {
      [".ecrc"] = {
        icon = "",
        name = "EditorConfigChecker",
        color = C.green,
      },
      [".envrc"] = {
        icon = "",
        name = "envrc",
        color = C.yellow,
      },
      [".editorconfig"] = {
        icon = "",
        name = "EditorConfig",
        color = C.green,
      },
      [".luacheckrc"] = {
        icon = "󰢱",
        name = "LuacheckRC",
        color = C.blue,
      },
      [".Justfile"] = justfile,
      [".justfile"] = justfile,
      ["Justfile"] = justfile,
      ["justfile"] = justfile,
    },
  })
end
