vim.filetype.add({
  extension = {
    jq = "jq",
    tmpl = "gohtmltmpl",
    rasi = "css",
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
  filename = {
    [".Justfile"] = "just",
    [".justfile"] = "just",
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
})
