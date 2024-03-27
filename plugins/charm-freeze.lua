return function()
	local wk = require("which-key")

	wk.register({
		["<leader>sc"] = { ":Freeze<cr>", "Snapshot code" },
	}, { mode = "v" })

	require("charm-freeze").setup({
		output = function()
			return "./" .. os.date("%Y-%m-%d") .. "_freeze.png"
		end,
		theme = "catppuccin-mocha",
		window = true,
		padding = { 20, 40, 20, 20 },
	})
end
