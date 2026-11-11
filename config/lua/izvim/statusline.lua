local M = {}

local icons = { default = "", n = "", i = "󰗧", v = "󰫙", c = "" }

local mode_names = {
  n = "NORMAL",
  no = "O-PENDING",
  i = "INSERT",
  v = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
  R = "REPLACE",
  c = "COMMAND",
  t = "TERMINAL",
  r = "PROMPT",
  ["!"] = "SHELL",
}

local mode_groups = {
  n = "Normal",
  i = "Insert",
  v = "Visual",
  V = "Visual",
  ["\22"] = "Visual",
  s = "Visual",
  S = "Visual",
  ["\19"] = "Visual",
  R = "Replace",
  c = "Command",
  t = "Terminal",
}

-- statusline groups, coloured from groups every colorscheme defines
local function set_highlights()
  local function get(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false })
  end
  local bar = get("StatusLine")

  for suffix, source in pairs({
    Normal = "Function",
    Insert = "String",
    Visual = "Statement",
    Replace = "DiagnosticError",
    Command = "Constant",
    Terminal = "DiagnosticOk",
  }) do
    vim.api.nvim_set_hl(0, "StatusMode" .. suffix, { fg = bar.bg, bg = get(source).fg, bold = true })
  end

  for suffix, source in pairs({ Add = "Added", Change = "Changed", Delete = "Removed" }) do
    vim.api.nvim_set_hl(0, "StatusDiff" .. suffix, { fg = get(source).fg, bg = bar.bg })
  end
end

local function git()
  local head = vim.b.gitsigns_head
  if not head or head == "" then
    return ""
  end

  -- escape `%` so a branch name can't be read as a statusline item
  local parts = { " " .. head:gsub("%%", "%%%%") }
  local diff = vim.b.gitsigns_status_dict or {}
  for _, item in ipairs({ { "added", "+", "Add" }, { "changed", "~", "Change" }, { "removed", "-", "Delete" } }) do
    local count = diff[item[1]]
    if count and count > 0 then
      parts[#parts + 1] = ("%%#StatusDiff%s#%s%d%%*"):format(item[3], item[2], count)
    end
  end
  return table.concat(parts, " ")
end

local function search_count()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local ok, count = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 50 })
  if not ok or (count.total or 0) == 0 then
    return ""
  end
  return ("[%d/%s]"):format(count.current, count.incomplete == 2 and ">999" or count.total)
end

function M.render()
  if vim.bo.filetype == "snacks_dashboard" then
    return ""
  end

  local mode = vim.api.nvim_get_mode().mode
  local first = mode:sub(1, 1)
  local mode_hl = "%#StatusMode" .. (mode_groups[first] or "Normal") .. "#"
  local name = mode_names[mode] or mode_names[first] or mode

  return table.concat({
    mode_hl,
    " ",
    icons[first] or icons.default,
    " ",
    name,
    " %* ",
    git(),
    " %<",
    vim.diagnostic.status(),
    " ",
    search_count(),
    "%=",
    vim.ui.progress_status(),
    " ",
    vim.bo.filetype,
    " %P ",
    mode_hl,
    " %l:%c ",
  })
end

function M.setup()
  set_highlights()

  local group = vim.api.nvim_create_augroup("izvim.statusline", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = set_highlights })

  -- these change what the statusline shows without always causing a redraw. the
  -- redraw is scheduled so it runs after vim.ui.progress_status() has seen the update
  local function redraw()
    vim.schedule(vim.cmd.redrawstatus)
  end
  vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged", "Progress" }, {
    group = group,
    callback = redraw,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "GitSignsUpdate",
    callback = redraw,
  })

  vim.o.statusline = "%!v:lua.require'izvim.statusline'.render()"
end

return M
