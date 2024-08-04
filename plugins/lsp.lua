return function()
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

  -- setup python
  pcall(require("py_lsp").setup, common)

  require("typescript-tools").setup({
    single_file_support = false,
    root_dir = function(fname)
      local root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json")(fname)

      -- this is needed to make sure we don't pick up root_dir inside node_modules
      local node_modules_index = root_dir and root_dir:find("node_modules", 1, true)
      if node_modules_index and node_modules_index > 0 then
        ---@diagnostic disable-next-line: need-check-nil
        root_dir = root_dir:sub(1, node_modules_index - 2)
      end

      return root_dir
    end,
    settings = {
      expose_as_code_action = {
        "add_missing_imports",
        "fix_all",
        "remove_unused",
      },
      tsserver_path = vim.fn.resolve(vim.fn.exepath("tsserver") .. "/../../lib/node_modules/typescript/bin/tsserver"),
    },
  })

  local servers = {}

  for server, config in pairs(servers) do
    if config == {} then
      lspconfig[server].setup(common)
    else
      lspconfig[server].setup(vim.tbl_extend("force", common, config))
    end
  end

  -- null ls stuff
  local null_present, null = pcall(require, "null-ls")

  if not null_present then
    return
  end

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local sources = {
    -- general
    null.builtins.formatting.treefmt.with({
      condition = function(utils)
        return utils.root_has_file("treefmt.toml")
      end,
    }),

    -- nix
    null.builtins.formatting.nixfmt,
    null.builtins.diagnostics.statix,
    null.builtins.diagnostics.deadnix,

    -- go
    null.builtins.formatting.gofumpt,

    -- webdev
    null.builtins.formatting.prettier.with({
      filetypes = {
        "html",
        "astro",
        "vue",
      },
    }),

    -- shell
    null.builtins.formatting.shfmt,

    -- lua
    null.builtins.formatting.stylua,

    -- docs
    null.builtins.diagnostics.alex,
    null.builtins.diagnostics.proselint,
  }

  null.setup({
    sources = sources,
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(c)
                return c.name == "null-ls"
              end,
            })
          end,
        })
      end
    end,
  })

  local toggle_formatters = function()
    null.toggle({ methods = null.methods.FORMATTING })
  end

  vim.api.nvim_create_user_command("ToggleFormatters", toggle_formatters, {})

  -- setup go stuff
  require("go").setup({
    disable_defaults = false,
    icons = {
      breakpoint = " ",
      currentpos = " ",
    },
    trouble = true,
    luasnip = true,
    dap_debug_keymap = false,
    lsp_cfg = false,
    lsp_keymaps = false,
    lsp_inlay_hints = {
      enable = true,
      style = "inlay",
    },
  })

  require("lspconfig").gopls.setup(require("go.lsp").config())
end
