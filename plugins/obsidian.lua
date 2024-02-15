return function()
	require("obsidian").setup({
		workspaces = {
			{
				name = "default",
				path = "~/Documents/obsidian",
			},
			{
				name = "default",
				path = "~/documents/obsidian",
			},
			{
				name = "default",
				path = "~/dev/cssuffering/notes",
			},
		},
		completion = {
			nvim_cmp = true,
		},
	})
end
