local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>d", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)

for i = 0, 4 do
  vim.keymap.set("n", "<leader>" .. i, function()
    harpoon:list():select(i)
  end)
end
