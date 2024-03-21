local M = {}

M.setup = function(opts)
	require("go").setup({
		disable_defaults = false,
		icons = {
			breakpoint = " ",
			currentpos = " ",
		},
		lsp_cfg = opts,
		trouble = true,
		luasnip = true,
	})
end

return M
