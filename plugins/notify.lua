return function()
	local notify = require("notify")
	notify.setup({
		background_colour = "#1e1e2e",
		timeout = 1000,
		render = "compact",
		stages = "fade",
	})
	vim.notify = notify
end
