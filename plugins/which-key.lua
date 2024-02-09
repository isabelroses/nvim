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
		-- telescope
		["<leader><leader>"] = {
			"<cmd>Telescope find_files<cr>",
			"Find file",
		},
		["<leader>f"] = {
			name = "+Telescope",
			g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
			s = { "<cmd>SessionManager load_session<cr>", "Show sessions" },
			-- h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
			-- n = { "<cmd>Telescope notify<cr>", "Show notifications" },
			p = { "<cmd>Telescope project<cr>", "Project" },
		},

		["<leader>u"] = {
			vim.cmd.UndotreeToggle,
			"Undo Tree",
		},

		-- save file
		["<C-s>"] = {
			"<cmd>w<cr>",
			"Save File",
		},

		-- reduce clutter
		["<leader>"] = {
			["1"] = "which_key_ignore",
			["2"] = "which_key_ignore",
			["3"] = "which_key_ignore",
			["4"] = "which_key_ignore",
		},
	})
end
