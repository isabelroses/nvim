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
    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

    local opts = { buffer = ev.buf }

    --- see |lsp-defaults|, `K` for hover is already mapped and 'winborder' handles borders
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>fm", function()
      require("conform").format({ async = true, lsp_format = "fallback" })
    end, opts)
  end,
})

-- forward LSP progress to native progress messages, which ui2 displays
local progress = {}
vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("izvim.lsp-progress", { clear = true }),
  callback = function(ev)
    local value = ev.data.params.value
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or type(value) ~= "table" then
      return
    end

    local key = ev.data.client_id .. ":" .. tostring(ev.data.params.token)
    local state = progress[key] or {}
    local done = value.kind == "end"

    state.title = value.title or state.title
    state.id = vim.api.nvim_echo({ { value.message or (done and "done" or "") } }, false, {
      id = state.id,
      kind = "progress",
      source = client.name,
      title = state.title,
      status = done and "success" or "running",
      percent = done and 100 or value.percentage,
    })

    progress[key] = not done and state or nil
  end,
  desc = "Show LSP progress",
})

local servers = {
  -- keep-sorted start block=yes
  astro = {},
  bashls = {},
  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  },
  cssls = {},
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
  gleam = {},
  gopls = {
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
  mdx_analyzer = {},
  nil_ls = {
    settings = {
      ["nil"] = {
        formatting = {
          command = { "nixfmt" },
        },
        diagnostics = {
          bindingEndHintMinLines = 2,
        },
      },
    },
  },
  nushell = {},
  pyright = {},
  qmlls = {
    cmd = { "qmlls", "-E" },
  },
  serve_d = {},
  statix = {},
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
  tinymist = {},
  ts_ls = {},
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
