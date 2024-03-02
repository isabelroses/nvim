return function()
	local wk = require("which-key")

	wk.register({
		["<leader>sc"] = { ":Silicon<cr>", "Snapshot code" },
	}, { mode = "v" })

	require("silicon").setup({
		font = "RobotoMono Nerd Font=20",

		theme = "Dracula",
		background = "#74c7ec",

		pad_vert = 80,
		pad_horiz = 50,

		command = "silicon",

		output = function()
			return "./" .. os.date("%Y-%m-%d") .. "_silicon.png"
		end,

		language = function()
			return vim.bo.filetype
		end,

		window_title = function()
			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
		end,
	})
end
