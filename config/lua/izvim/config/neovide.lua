if not vim.g.neovide then
  return
end

if vim.loop.os_uname().sysname == "Darwin" then
  vim.g.neovide_transparency = 0.6
  -- options only currently available on macOS
  vim.g.neovide_window_blurred = true
else
  vim.g.neovide_transparency = 0.8
end
