if not vim.g.neovide then
  return
end

-- background --
vim.g.neovide_opacity = 1.0

local function neovide_alpha()
  return string.format("%02x", math.floor(255 * (vim.g.transparency or 0.8)))
end

if vim.uv.os_uname().sysname == "Darwin" then
  vim.g.neovide_normal_opacity = 0.6
  -- options only currently available on macOS
  vim.g.neovide_window_blurred = true
else
  vim.g.neovide_normal_opacity = 0.9
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("neovide:background", { clear = true }),
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    local bg = string.format("%06x", normal.bg or 0)
    local fg = string.format("%06x", normal.fg or 0)
    vim.g.neovide_background_color = bg .. neovide_alpha()
    vim.g.neovide_title_background_color = bg
    vim.g.neovide_title_text_color = fg
  end,
})
vim.api.nvim_exec_autocmds("ColorScheme", {})

-- font & cursor --

vim.g.fontsize = 14
vim.g.lineheight = 1.2
vim.o.guifont = string.format("Maple Mono NF:h%d", vim.g.fontsize)
vim.opt.linespace = math.floor((vim.g.lineheight - 1) * vim.g.fontsize)

-- behavior --
vim.g.neovide_detach_on_quit = "always_detach"

vim.keymap.set("n", "<m-enter>", function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  if vim.g.neovide_fullscreen then
    vim.notify("enabling fullscreen")
  else
    vim.notify("disabling fullscreen")
  end
end, { silent = true })
