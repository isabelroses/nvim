return function()
	local wk = require("which-key")

	wk.register({
		["<leader>sc"] = { ":Freeze<cr>", "Snapshot code" },
	}, { mode = "v" })

	require("charm-freeze").setup()
end
