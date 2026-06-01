vim.filetype.add({
  extension = {
    jq = "jq",
    tmpl = "gohtmltmpl",
    rasi = "scss",
    envrc = "bash",
    tera = "tera",
    mdx = "mdx",
  },
  filename = {
    ["flake.lock"] = "json",
    [".Justfile"] = "just",
    [".justfile"] = "just",
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
})

-- there's no dedicated mdx grammar, so reuse the markdown one
vim.treesitter.language.register("markdown", "mdx")

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    -- keep-sorted start
    "bash",
    "c",
    "checkhealth",
    "comment",
    "cpp",
    "css",
    "csv",
    "dhall",
    "diff",
    "dockerfile",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "gleam",
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
    "mdx",
    "nix",
    "nu",
    "php",
    "purescript",
    "python",
    "qmldir",
    "qmljs",
    "toml",
    "tsx",
    "typescript",
    "typst",
    "yaml",
    "yuck",
    -- keep-sorted end
  },
  callback = function(ev)
    vim.api.nvim_buf_call(ev.buf, function()
      vim.treesitter.start()
    end)
  end,
})
