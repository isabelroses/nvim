local lsp_present, lspconfig = pcall(require, "lspconfig")
local cmp_present, cmp = pcall(require, "cmp")
local navic_present, navic = pcall(require, "nvim-navic")
local luasnip_present, luasnip = pcall(require, "luasnip")

if not (cmp_present and lsp_present and luasnip_present) then
  vim.notify("lsp, cmp, luasnip not present", vim.log.levels.ERROR)
  return
end

vim.opt.completeopt = "menu,menuone,noselect"
require("luasnip.loaders.from_vscode").lazy_load()
vim.lsp.set_log_level("trace")

-- border style
require("lspconfig.ui.windows").default_options.border = vim.g.bc.style
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = vim.g.bc.style,
})
local cmp_borders = {
  border = {
    vim.g.bc.topleft,
    vim.g.bc.horiz,
    vim.g.bc.topright,
    vim.g.bc.vert,
    vim.g.bc.botright,
    vim.g.bc.horiz,
    vim.g.bc.botleft,
    vim.g.bc.vert,
  },
  winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
}

-- require("copilot_cmp").setup() -- setup copilot cmp
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp_borders,
    documentation = cmp_borders,
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({
            select = true,
          })
        end
      else
        fallback()
      end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    -- { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer" },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({
        mode = "symbol_text",
        ellipsis_char = "…",
        maxwidth = 50,
        symbol_map = { Copilot = "" },
      })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })

      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "   (" .. (strings[2] or "") .. ")"

      return kind
    end,
  },
})

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    cmp.setup.buffer({ sources = { { name = "crates" } } })
  end,
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path", option = { trailing_slash = true } },
  }, {
    { name = "cmdline" },
  }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client == nil then
      return
    end

    if navic_present and client.server_capabilities.documentSymbolProvider then
      navic.attach(client, ev.buf)
    end

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>fm", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

local common = { capabilities = capabilities }

require("isabel.lsp.go")
require("isabel.lsp.ltex").setup(common)
require("isabel.lsp.null-ls")
require("isabel.lsp.nix").setup(common)
require("isabel.lsp.validation").setup(common)
require("isabel.lsp.webdev").setup(common)
pcall(require("py_lsp").setup, common)

local servers = {
  "bashls",
  "dockerls",
  "jqls",
  "lua_ls",
  "serve_d",
  "sourcekit",
  "taplo",
  "teal_ls",
  "nushell",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup(common)
end
