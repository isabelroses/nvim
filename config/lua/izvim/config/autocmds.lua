vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
  desc = "Automatically resize windows when the host window size changes.",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  callback = function(data)
    local msg = data.event == "RecordingEnter" and "Recording macro..." or "Macro recorded"
    vim.notify(msg, vim.log.levels.INFO, { title = "Macro" })
  end,
  desc = "Notify when recording macro",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tmpl",
  callback = function()
    vim.bo.filetype = "gohtmltmpl"
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    local opts = { buffer = 0 }
    vim.cmd("startinsert!")
    vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n><C-w>]], opts)
    vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  end,
})
