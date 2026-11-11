-- give lua_ls the runtime and every plugin's lua dir. pathStrict stops require("fzf-lua")
-- also matching our plugins/fzf-lua.lua; the built copy of this config is skipped
local plugins = vim.tbl_filter(function(dir)
  return not dir:find("/init-plugin/", 1, true)
end, vim.fn.globpath(vim.o.packpath, "pack/*/*/*/lua", false, true))

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        pathStrict = true,
        path = { "?.lua", "?/init.lua", "config/lua/?.lua", "config/lua/?/init.lua" },
      },
      workspace = {
        library = vim.list_extend({ vim.env.VIMRUNTIME .. "/lua" }, plugins),
      },
    },
  },
})
