if not vim.g.neovide then
	return
end

vim.opt.guifont = "RobotoMono Nerd Font,Symbols Nerd Font:h14:#e-subpixelantialias"
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_scroll_animation_length = 0.3
vim.keymap.set("n", "<M-CR>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {
	noremap = true,
	silent = true,
})

vim.g.neovide_scale_factor = 1.0

local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<M-=>", function()
	change_scale_factor(1.25)
end)
vim.keymap.set("n", "<M-->", function()
	change_scale_factor(1 / 1.25)
end)
