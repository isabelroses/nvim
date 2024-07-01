return function()
  local ctp_present, ctp_pallets = pcall(require, "catppuccin.palettes")

  if ctp_present then
    local C = ctp_pallets.get_palette()

    local justfile = {
      icon = "󱚣",
      name = "Justfile",
      color = C.peach,
    }

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
  else
    require("nvim-web-devicons").setup()
  end
end
