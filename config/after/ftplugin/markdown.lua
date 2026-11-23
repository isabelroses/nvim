local patterns = {
  "^(%s*[-*+] %[)(.)(%])",
  "^(%s*%d+[.)] %[)(.)(%])",
}

---@return string? pattern the checkbox pattern matching the current line
---@return string? state the char between the brackets
local function find()
  local line = vim.api.nvim_get_current_line()
  for _, pattern in ipairs(patterns) do
    local _, state = line:match(pattern)
    if state then
      return pattern, state
    end
  end
end

---@param state string
local function set_state(state)
  local pattern = find()
  if pattern then
    vim.api.nvim_set_current_line((vim.api.nvim_get_current_line():gsub(pattern, "%1" .. state .. "%3", 1)))
  end
end

local cycle = { " ", "@", "s", "x" }

---@param current string the state the checkbox has now
---@return string? next the state to switch to, nil to leave the checkbox alone
local function next_state(current)
  -- TODO(isabel): decide what the cycle does
end

local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
end

map("<leader>tc", function()
  local _, current = find()
  local next = current and next_state(current)
  if next then
    set_state(next)
  end
end, "cycle todo state")

for _, state in ipairs({ "d", "b", "!", "?" }) do
  map("<leader>t" .. state, function()
    set_state(state)
  end, "mark todo [" .. state .. "]")
end
