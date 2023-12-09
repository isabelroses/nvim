local plugins = require("lazy").plugins()

-- drop the trailing `.nvim`, replace dots with dashes
local function toNvfetcherName(name)
	return name:lower():gsub("%.nvim$", ""):gsub("%.", "-")
end

table.sort(plugins, function(a, b)
	return toNvfetcherName(a.name) < toNvfetcherName(b.name)
end)

local c = ""
for _, plugin in ipairs(plugins) do
	local name = toNvfetcherName(plugin.name)

	if plugin.url then
		-- get rid of the .git at the end
		local url = plugin.url:sub(1, -5)

		c = c .. "[" .. name .. "]\n"
		if url:find("github") then
			c = c .. 'fetch.github = "' .. url:gsub("%w+://github.com/", "") .. '"\n'
		else
			c = c .. 'fetch.git = "' .. url .. '"\n'
		end
		c = c .. 'src.git = "' .. url .. '"\n'
	end

	if plugin.branch then
		c = c .. 'src.branch = "' .. plugin.branch .. '"\n'
	end
	c = c .. "\n"
end

-- write the plugins to a file
local file = io.open("nvfetcher.toml", "w")
if not file then
	error("Could not open file for writing")
end
file:write(c)
file:close()
