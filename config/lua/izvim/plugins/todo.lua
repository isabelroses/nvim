-- todo comments with todo-comments.nvim's keywords, by MiniHipatterns highlight group.
-- like todo-comments, a keyword only counts when a colon follows it ("TODO:")
local keywords = {
  Fixme = { "FIX", "FIXME", "BUG", "FIXIT", "ISSUE" },
  Todo = { "TODO" },
  Hack = { "HACK", "WARN", "WARNING", "XXX" },
  Note = { "PERF", "OPTIM", "PERFORMANCE", "OPTIMIZE", "NOTE", "INFO", "TEST", "TESTING", "PASSED", "FAILED" },
}

---@type lz.n.PluginSpec[]
return {
  {
    "mini.hipatterns",
    event = "DeferredUIEnter",
    after = function()
      local highlighters, words = {}, {}
      for group, list in pairs(keywords) do
        for _, word in ipairs(list) do
          words[#words + 1] = word
          highlighters[word] = { pattern = "%f[%w]()" .. word .. "()%s*:", group = "MiniHipatterns" .. group }
        end
      end
      require("mini.hipatterns").setup({ highlighters = highlighters })

      -- the same grep todo-comments' :TodoFzfLua runs
      vim.keymap.set("n", "<leader>ft", function()
        local search = [[\b(]] .. table.concat(words, "|") .. [[):]]
        -- headers/prompt: don't show the regex, fzf-lua puts it in both by default
        require("fzf-lua").grep({
          search = search,
          no_esc = true,
          multiline = true,
          headers = false,
          prompt = "Todos> ",
        })
      end, { desc = "grep for TODOs and FIXMEs" })
    end,
  },
}
