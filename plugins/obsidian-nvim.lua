return function()
	require("obsidian").setup({
		workspaces = {
			{
				name = "default",
				path = "~/documents/obsidian",
			},
		},
		completion = {
			nvim_cmp = true,
		},
	})
end
