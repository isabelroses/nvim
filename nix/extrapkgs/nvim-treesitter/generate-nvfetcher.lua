#!/usr/bin/env -S nvim -l
local parsers = require("nvim-treesitter.parsers").list

parsers.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c" },
  },
}
parsers.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" },
  },
}
parsers.tera = {
  install_info = {
    url = "https://github.com/uncenter/tree-sitter-tera",
    files = { "src/parser.c" },
  },
}

local keys = {}
for lang, _ in pairs(parsers) do
  table.insert(keys, lang)
end
table.sort(keys)

local file = io.open("nvfetcher.toml", "w")
if not file then
  error("Could not open file for writing")
end

-- the tresitter plugin itself
file:write("[nvim-treesitter]\n")
file:write('fetch.git = "https://github.com/nvim-treesitter/nvim-treesitter"\n')
file:write('src.git = "https://github.com/nvim-treesitter/nvim-treesitter"\n')
file:write("\n")

-- all available grammars
for _, lang in pairs(keys) do
  local info = parsers[lang].install_info

  file:write("[treesitter-grammar-" .. lang .. "]\n")
  file:write('fetch.git = "' .. info.url .. '"\n')
  file:write('src.git = "' .. info.url .. '"\n')
  if info.branch then
    file:write('src.branch = "' .. info.branch .. '"\n')
  end

  if info.location or info.requires_generate_from_grammar then
    file:write("[treesitter-grammar-" .. lang .. ".passthru]\n")
    if info.requires_generate_from_grammar then
      file:write('generate = "true"\n')
    end
    if info.location then
      file:write('location = "' .. info.location .. '"\n')
    end
  end
  file:write("\n")
end

file:close()
vim.cmd("q")
