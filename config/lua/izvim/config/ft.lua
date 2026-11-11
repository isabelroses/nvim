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

-- map filetypes to the parser that handles them, when the names differ.
-- nvim-treesitter would normally do this for us, but we only ship the parsers
for lang, filetypes in pairs({
  bash = { "sh" },
  git_rebase = { "gitrebase" },
  gotmpl = { "gohtmltmpl", "gotexttmpl" },
  javascript = { "javascriptreact" },
  json = { "jsonc" },
  latex = { "tex", "plaintex" },
  markdown = { "mdx" }, -- there's no dedicated mdx grammar
  qmljs = { "qml" },
  tsx = { "typescriptreact" },
}) do
  vim.treesitter.language.register(lang, filetypes)
end

-- start treesitter for any filetype with a parser (see `grammars` in package.nix)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(ev.buf, lang)
    end
  end,
  desc = "Start treesitter highlighting",
})
