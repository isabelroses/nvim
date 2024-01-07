return function()
	local wk = require("which-key")

	wk.setup({
		key_labels = {
			["<space>"] = "󱁐 ",
			["<leader>"] = "󱁐 ",
			["<bs>"] = "󰌍 ",
			["<cr>"] = "󰌑 ",
			["<esc>"] = "󱊷 ",
			["<tab>"] = "󰌒 ",
		},
		window = {
			border = vim.g.bc.style,
			margin = { 0, 0, 0, 0 },
		},
	})

	wk.register({
		["<leader>"] = {
			y = { '"+y', "Copy to clipboard" },
			p = { '"+p', "Paste from clipboard" },
			gg = { "<cmd>LazyGit<cr>", "LazyGit" },
			q = { "<cmd>qall<cr>", "Quit all" },
		},
	}, { mode = { "n", "v" } })

	wk.register({
		["<C-s>"] = {
			"<cmd>w<cr>",
			"Save File",
		},
		["<leader>"] = {
			["1"] = "which_key_ignore",
			["2"] = "which_key_ignore",
			["3"] = "which_key_ignore",
			["4"] = "which_key_ignore",
		},
	})
end
