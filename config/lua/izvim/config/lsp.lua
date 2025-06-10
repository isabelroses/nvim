require("lz.n").trigger_load({
  "blink.cmp",
  "lsp-status.nvim",
  "schemastore.nvim",
  "py_lsp.nvim",
  "typescript-tools.nvim",
})

local lsp_present, lspconfig = pcall(require, "lspconfig")
local navic_present, navic = pcall(require, "nvim-navic")

if not lsp_present then
  vim.notify("lspnot present", vim.log.levels.ERROR)
  return
end

-- border style
require("lspconfig.ui.windows").default_options.border = vim.g.bc.style

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

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end

    local opts = { buffer = ev.buf }
    local function use_border(cb)
      return function()
        cb({ border = vim.g.bc.style })
      end
    end
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", use_border(vim.lsp.buf.hover), opts)
    vim.keymap.set("n", "<C-k>", use_border(vim.lsp.buf.signature_help), opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>fm", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

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
    tsserver_path = vim.fn.resolve(
      vim.fn.exepath("tsserver") .. "/../../lib/node_modules/typescript/bin/tsserver"
    ),
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

local servers = {
  astro = {},
  bashls = {},
  cssls = {},
  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  },
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
  graphql = {
    filetypes = {
      "graphql",
      "typescriptreact",
      "javascriptreact",
      "typescript",
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
  harper_ls = {
    settings = {
      ["harper-ls"] = {
        linters = {
          SentenceCapitalization = false,
        },
      },
    },
  },
  marksman = {},
  nil_ls = {
    on_attach = function(client, bufnr)
      if client.server_capabilities then
        client.server_capabilities.semanticTokensProvider = false
      end
    end,
    autostart = true,
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
  -- sourcekit = {},
  stylelint_lsp = {},
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
}

vim.lsp.config("*", common)
for server, config in pairs(servers) do
  vim.schedule(function()
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end)
end
