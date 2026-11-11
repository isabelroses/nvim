---@type lz.n.PluginSpec[]
return {
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    after = function()
      ---@type blink.cmp.Config
      local opts = {
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

        completion = {
          list = {
            cycle = {
              from_top = false,
              from_bottom = false,
            },
          },

          menu = {
            max_height = vim.o.pumheight,
            scrolloff = 0,
            border = "none",
            draw = {
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

        sources = {
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
            return vim.bo.filetype == "markdown" and 2 or 1
          end,
        },

        signature = {
          enabled = true,
        },

        fuzzy = {
          max_typos = 0,
          prebuilt_binaries = {
            download = false,
          },
        },
      }

      require("blink.cmp").setup(opts)
    end,
  },

  { "SchemaStore.nvim" },

  {
    "crates.nvim",
    after = function()
      require("crates").setup({})
    end,
    event = "BufRead Cargo.toml",
  },

  {
    "rustaceanvim",
    lazy = false,
    after = function()
      vim.g.rustaceanvim = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { buffer = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
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

  { "rainbow-delimiters.nvim" },

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

      -- some linters (selene, yamllint) aren't bundled, so stay quiet when they're missing
      local function lint()
        require("lint").try_lint(nil, { ignore_errors = true })
      end

      -- lint on open and save. add "InsertLeave" to lint while editing
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("izvim.lint", { clear = true }),
        callback = lint,
        desc = "Run nvim-lint linters",
      })

      -- we load after the first buffer was read, so lint it now
      lint()
    end,
  },

  {
    "conform.nvim",
    event = "DeferredUIEnter",
    after = function()
      ---@type conform.setupOpts
      local opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          nix = { "nixfmt" },
          go = { "gofumpt" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          toml = { "taplo" },
        },
        format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
      }

      require("conform").setup(opts)
    end,
  },
}
