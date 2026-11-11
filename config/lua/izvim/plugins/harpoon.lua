---@type lz.n.PluginSpec[]
return {
  {
    -- lmao
    "harpoon2",
    event = "DeferredUIEnter",
    after = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>d", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)

      -- harpoon lists are 1-indexed
      for i = 1, 4 do
        vim.keymap.set("n", "<leader>" .. i, function()
          harpoon:list():select(i)
        end)
      end
    end,
  },
}
