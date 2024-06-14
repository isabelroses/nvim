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

  require("isabel.lsp.go")
  require("isabel.lsp.null-ls")
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

  local servers = {
    astro = {},
    bashls = {},
    cssls = {},
    denols = {
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      single_file_support = false,
    },
    dockerls = {},
    emmet_language_server = {
      filetypes = {
        "astro",
        "css",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "pug",
        "typescriptreact",
      },
    },
    graphql = {
      filetypes = {
        "graphql",
        "typescriptreact",
        "javascriptreact",
        "typescript",
      },
    },
    helm_ls = {},
    hls = {},
    html = {},
    intelephense = {},
    jqls = {},
    jsonls = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
    lua_ls = {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    },
    ltex = {
      on_attach = function()
        require("ltex_extra").setup({
          load_langs = { "en-US", "en-GB" },
          init_check = true,
          path = vim.fn.stdpath("data") .. "/dictionary",
        })
      end,
      settings = {
        ltex = {
          language = "en-US",
          additionalRules = {
            enablePickyRules = true,
            motherTongue = "en_GB",
          },
        },
      },
    },
    marksman = {},
    nil_ls = {
      autostart = true,
      capabilities = capabilities,
      cmd = { "nil" },
      settings = {
        ["nil"] = {
          formatting = {
            command = { "nixfmt" },
          },
          nix = { maxMemoryMB = nil },
        },
      },
    },
    nushell = {},
    serve_d = {},
    sourcekit = {},
    taplo = {},
    teal_ls = {},
    tailwindcss = {
      filetypes = {
        "astro",
        "javascriptreact",
        "typescriptreact",
        "html",
        "css",
      },
    },
    volar = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
      root_dir = require("lspconfig.util").root_pattern("package.json"),
    },
    yamlls = {
      settings = {
        yaml = {
          completion = true,
          validate = true,
          suggest = {
            parentSkeletonSelectedFirst = true,
          },
          schemas = vim.tbl_extend("keep", {
            ["https://json.schemastore.org/github-action"] = ".github/action.{yaml,yml}",
            ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*lab-ci.{yaml,yml}",
            ["https://json.schemastore.org/helmfile"] = "helmfile.{yaml,yml}",
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
            ["https://goreleaser.com/static/schema.json"] = ".goreleaser.{yml,yaml}",
          }, require("schemastore").yaml.schemas()),
        },
        redhat = {
          telemetry = {
            enabled = false,
          },
        },
      },
    },
  }

  for server, config in pairs(servers) do
    if config == {} then
      lspconfig[server].setup(common)
    else
      lspconfig[server].setup(vim.tbl_extend("force", common, config))
    end
  end
end
