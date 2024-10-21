local M = {}

M.loaded = false

M.check = function()
  vim.health.start("izvim report")

  if M.loaded then
    vim.health.ok("izvim loaded correctly")
  else
    vim.health.error("izvim did not loaded correctly")
  end

  local deps = {
    "direnv", -- direnv.nvim doesn't provide a checkhealth command
    "lazygit", -- there is no plugin that requires lazygit but I have a keybind to open it
  }

  for _, dep in ipairs(deps) do
    if vim.fn.executable(dep) == 1 then
      vim.health.ok(dep .. " is installed")
    else
      vim.health.error(dep .. " is not installed")
    end
  end
end
return M
