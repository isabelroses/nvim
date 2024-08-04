vim.filetype.add({
  extension = {
    jq = "jq",
    tmpl = "gohtmltmpl",
    rasi = "scss",
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    ["flake.lock"] = "json",
  },
  filename = {
    [".Justfile"] = "just",
    [".justfile"] = "just",
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
})
