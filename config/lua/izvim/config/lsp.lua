require("lz.n").trigger_load({
  "lsp-status.nvim",
  "schemastore.nvim",
})

local lsp_present, lspconfig = pcall(require, "lspconfig")
local navic_present, navic = pcall(require, "nvim-navic")

if not lsp_present then
  vim.notify("lspconfig not present", vim.log.levels.ERROR)
  return
end

vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client == nil then
      return
    end

    if navic_present and client.server_capabilities.documentSymbolProvider then
      navic.attach(client, ev.buf)
    end

    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

    local opts = { buffer = ev.buf }
    --- see |lsp-defaults|
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>fm", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

local servers = {
  -- keep-sorted start block=yes
  astro = {},
  bashls = {},
  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  },
  cssls = {},
  denols = {
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    single_file_support = false,
    settings = {
      deno = {
        inlayHints = {
          parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enable = true },
          enumMemberValues = { enabled = true },
        },
      },
    },
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
  gopls = {
    single_file_support = true,
    filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    cmd = {
      "gopls", -- share the gopls instance if there is one already
      "-remote.debug=:0",
    },
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = "Fuzzy",
        diagnosticsDelay = "500ms",
        symbolMatcher = "fuzzy",
        semanticTokens = true,
        gofumpt = true,
      },
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
  harper_ls = {
    settings = {
      ["harper-ls"] = {
        linters = {
          SentenceCapitalization = false,
        },
      },
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
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        hint = {
          enable = true,
          arrayIndex = "Disable",
        },
      },
    },
  },
  marksman = {},
  nil_ls = {
    cmd = { "nil" },
    settings = {
      ["nil"] = {
        formatting = {
          command = { "nixfmt" },
        },
        diagnostics = {
          bindingEndHintMinLines = 2,
        },
        nix = { maxMemoryMB = nil },
      },
    },
    capabilities = {
      semanticTokensProvider = false,
    },
  },
  nushell = {},
  pyright = {},
  qmlls = {
    cmd = { "qmlls", "-E" },
  },
  serve_d = {},
  statix = {},
  -- sourcekit = {},
  stylelint_lsp = {},
  tailwindcss = {
    filetypes = {
      "astro",
      "javascriptreact",
      "typescriptreact",
      "html",
      "css",
    },
  },
  taplo = {},
  teal_ls = {},
  vtsls = {
    root_dir = function(fname)
      local root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json")(fname)

      -- this is needed to make sure we don't pick up root_dir inside node_modules
      local node_modules_index = root_dir and root_dir:find("node_modules", 1, true)
      if node_modules_index and node_modules_index > 0 then
        root_dir = root_dir:sub(1, node_modules_index - 2)
      end

      return root_dir
    end,
  },
  vue_ls = {},
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
  -- keep-sorted end
}

for server, config in pairs(servers) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
