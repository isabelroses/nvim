return {
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    after = function()
      require("blink.cmp").setup({
        keymap = {
          ["<c-space>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
          ["<C-e>"] = { "hide" },
          ["<tab>"] = {
            "select_and_accept",
            "snippet_forward",
            "fallback",
          },
          ["<s-tab>"] = { "snippet_backward", "fallback" },
          ["<down>"] = { "select_next", "fallback" },
          ["<up>"] = { "select_prev", "fallback" },
          ["<c-j>"] = { "scroll_documentation_down", "fallback" },
          ["<c-k>"] = { "scroll_documentation_up", "fallback" },
        },

        appearance = {},

        completion = {
          trigger = {
            show_on_keyword = true,
          },
          list = {
            cycle = {
              from_top = false,
              from_bottom = false,
            },
          },

          menu = {
            min_width = vim.o.pumwidth,
            max_height = vim.o.pumheight,
            scrolloff = 0,
            draw = {
              -- align_to = "label", -- or 'none' to disable, or 'cursor' to align to the cursor
              padding = 1,
              gap = 1,
              treesitter = { "buffer", "lsp" },
              columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
              components = {
                source_name = {
                  width = { max = 30 },
                  text = function(ctx)
                    return string.format("(%s)", ctx.source_name)
                  end,
                  highlight = "BlinkCmpSource",
                },
              },
            },
          },

          ghost_text = {
            enabled = true,
          },
        },

        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },

          providers = { snippets = { opts = { search_paths = { vim.g.snippets_path } } } },

          transform_items = function(_, items)
            return vim
              .iter(ipairs(items))
              :map(function(_, item)
                if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                  item.score_offset = item.score_offset + 1
                end
                return item
              end)
              :totable()
          end,
          min_keyword_length = function()
            local default = 1
            return vim.bo.filetype == "markdown" and 2 or default
          end,
        },

        -- experimental signature help support
        signature = {
          enabled = true,
        },

        fuzzy = {
          max_typos = function(_)
            return 0
          end,
          -- frecency tracks the most recently/frequently used items and boosts the score of the item
          use_frecency = false,
          -- proximity bonus boosts the score of items matching nearby words
          use_proximity = true,

          prebuilt_binaries = {
            download = false,
          },
        },
      })
    end,
  },

  { "lsp-status.nvim" },
  { "schemastore.nvim" },
  { "py_lsp.nvim" },

  {
    "nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      local lsp_present, lspconfig = pcall(require, "lspconfig")
      local navic_present, navic = pcall(require, "nvim-navic")

      if not lsp_present then
        vim.notify("lspnot present", vim.log.levels.ERROR)
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

          vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

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
              diagnostics = {
                bindingEndHintMinLines = 2,
              },
              nix = { maxMemoryMB = nil },
            },
          },
        },
        nushell = {},
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
          single_file_support = false,
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

      vim.lsp.config("*", common)
      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },

  {
    "crates.nvim",
    after = function()
      require("crates").setup({})
    end,
    event = "BufRead Cargo.toml",
  },

  {
    "quill.nvim",
    event = "BufReadPost",
    after = function()
      require("quill").setup()
    end,
  },

  { "rainbow-delimiters.nvim" },

  {
    "rustaceanvim",
    lazy = false,
    after = function()
      vim.g.rustaceanvim = {
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end)
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { buffer = bufnr })
        end,
        tools = {
          float_win_config = {
            border = "rounded",
          },
        },
        settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      }
    end,
  },

  {
    "lazydev.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("lazydev").setup()
    end,
  },

  {
    "nvim-lint",
    event = "DeferredUIEnter",
    after = function()
      require("lint").linters_by_ft = {
        nix = { "nix", "statix", "deadnix" },
        lua = { "selene" },
        markdown = { "proselint" },
        tex = { "proselint" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        yaml = { "yamllint" },
      }
    end,
  },

  {
    "formatter.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("formatter").setup({
        filetype = {
          ["*"] = {
            function()
              if not vim.fs.root(0, "treefmt.toml") then
                return nil
              end

              return {
                exe = "treefmt",
                args = {
                  "--allow-missing-formatter",
                },
                stdin = true,
              }
            end,
          },

          lua = { require("formatter.filetypes.lua").stylua },
          nix = { require("formatter.filetypes.nix").nixfmt },
          go = { require("formatter.filetypes.go").gofumpt },
          sh = { require("formatter.filetypes.sh").shfmt },
          bash = { require("formatter.filetypes.sh").shfmt },
          toml = { require("formatter.filetypes.toml").taplo },
        },
      })

      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      augroup("__formatter__", { clear = true })
      autocmd("BufWritePost", {
        group = "__formatter__",
        command = ":FormatWrite",
      })
    end,
  },
}
