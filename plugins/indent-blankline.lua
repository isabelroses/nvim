return function()
	require("ibl").setup({
		exclude = {
			filetypes = {
				"alpha",
				"fugitive",
				"help",
				"lazy",
				"LazyGit",
				"NvimTree",
				"TelescopePrompt",
				"Trouble",
			},
		},
	})
end
