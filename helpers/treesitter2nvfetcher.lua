local parsers = require("nvim-treesitter.parsers")
local parser_list = parsers.available_parsers()
table.sort(parser_list)

local c = ""

for _, lang in pairs(parser_list) do
	-- optional: check if the parser is installed
	-- local is_installed = #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0
	-- if is_installed then ... end

	local info = parsers.get_parser_configs()[lang].install_info

	c = c .. "[tree-sitter-grammar-" .. lang .. "]\n"
	c = c .. 'fetch.git = "' .. info.url .. '"\n'
	c = c .. 'src.git = "' .. info.url .. '"\n'
	if info.branch then
		c = c .. 'src.branch = "' .. info.branch .. '"\n'
	end
	if info.location then
		c = c .. 'passthru = { location = "' .. info.location .. '" }\n'
	end
	c = c .. "\n"
end

-- write the plugins to a file
local file = io.open("pkgs/nvim-treesitter/nvfetcher.toml", "w")
if not file then
	error("Could not open file for writing")
end
file:write(c)
file:close()
