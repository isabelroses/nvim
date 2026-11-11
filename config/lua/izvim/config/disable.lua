-- disable builtin vim plugins I don't use
for _, plugin in ipairs({
  "zipPlugin",
  "zip",
  "tarPlugin",
  "tar",
  "gzip",
  "tutor_mode_plugin",
  "matchit",
  "netrw",
  "netrwPlugin",
}) do
  vim.g["loaded_" .. plugin] = 1
end
