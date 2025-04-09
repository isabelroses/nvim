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

  {
    "none-ls.nvim",
    event = "DeferredUIEnter",
    after = function()
      local null = require("null-ls")

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
        null.builtins.diagnostics.selene,

        -- docs
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

      local toggle_diagnostics = function()
        null.toggle({ methods = null.methods.DIAGNOSTICS })
      end

      vim.api.nvim_create_user_command("ToggleFormatters", toggle_formatters, {})
      vim.api.nvim_create_user_command("ToggleDiagnostics", toggle_diagnostics, {})
    end,
  },

  { "lsp-status.nvim" },
  { "ltex-extra.nvim" },
  { "schemastore.nvim" },
  { "py_lsp.nvim" },
  { "typescript-tools.nvim" },

  {
    "nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      require("lz.n").trigger_load({
        "blink.cmp",
        "lsp-status.nvim",
        "ltex-extra.nvim",
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
        ltex_plus = {
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
        lspconfig[server].setup(vim.tbl_extend("force", common, config))
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
    after = function()
      require("quill").setup()
    end,
  },

  { "rainbow-delimiters.nvim" },

  {
    "rustaceanvim",
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
    after = function()
      require("lazydev").setup()
    end,
  },
}
