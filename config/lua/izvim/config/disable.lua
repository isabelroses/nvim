-- disable builtin vim plugins I don't use
local plugins =
  { "zipPlugin", "zip", "tarPlugin", "tar", "gzip", "tutor_mode_plugin", "matchit", "netrw", "netrwPlugin" }
for _, plugin in ipairs(plugins) do
  vim.g["loaded_" .. plugin] = 1
end
