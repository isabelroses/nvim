-- by default unload all vim plugins
local loaded_plugins = {
  "zipPlugin",
  "zip",
  "tarPlugin",
  "tar",
  "gzip",
  "tutor_mode_plugin",
  "matchit",
  "netrw",
  "netrwPlugin",
}
vim.iter(ipairs(loaded_plugins)):each(function(_, k)
  vim.g["loaded_" .. k] = 1
end)
