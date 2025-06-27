vim.filetype.add({
  extension = {
    jq = "jq",
    tmpl = "gohtmltmpl",
    rasi = "scss",
    envrc = "bash",
    tera = "tera",
  },
  filename = {
    ["flake.lock"] = "json",
    [".Justfile"] = "just",
    [".justfile"] = "just",
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "bash",
    "c",
    "cpp",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "graphql",
    "haskell",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "just",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "nu",
    "php",
    "toml",
    "qmldir",
    "qmljs",
    "yaml",
    "yuck",
    "checkhealth",
  },
  callback = function(ev)
    vim.api.nvim_buf_call(ev.buf, function()
      vim.treesitter.start()
    end)
  end,
})
