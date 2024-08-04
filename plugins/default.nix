{ pkgs }:
let
  srcs = builtins.mapAttrs (_: pkg: pkg.src) (pkgs.callPackage ../_sources/generated.nix { });
  inherit (pkgs) lib;
  inherit (lib.generators) mkLuaInline;
in
{
  config = {
    ui = {
      colorscheme = "evergarden";
      transparent_background = false;
    };
  };

  modules = {
    ch = [
      { name = "base"; }
      { name = "options"; }

      {
        name = "lazy";
        enabled = true;
      }
      {
        name = "whichkey";
        enabled = false;
      }

      {
        name = "keymaps";
        opts = {
          defaults = { };
          qf_loaders = { };
          leader = "SPC";
          localleader = "SPC";
          mappings = {
            custom = [
              [
                "normal"
                "<leader>q"
                "<cmd>qall<cr>"
                "quit all"
              ]
            ];

            # quick fix list
            qf_list = [
              [
                "normal"
                "<c-n>"
                ":cnext<cr>"
                "goto next item in qf list"
              ]
              [
                "normal"
                "<c-b>"
                ":cprev<cr>"
                "goto prev item in qf list"
              ]
              [
                "normal"
                "<leader>qf"
                (mkLuaInline ''
                  function()
                    local items = ch.lib.options:get('keymaps', 'qf_loaders')
                    vim.ui.select(vim.tbl_keys(items), {}, function(item)
                      if not item then
                        return
                      end
                      local fn = items[item]
                      if fn and type(fn) == 'function' then
                        fn()
                      end
                    end)
                  end
                '')
                "load qf list items"
              ]
              [
                "normal"
                "<leader>sq"
                (mkLuaInline ''
                  function()
                    ch.lib.keymaps.open_qf_list()
                  end
                '')
                "open qf list"
              ]
            ];

            copy_paste = [
              [
                "normal"
                "<leader>p"
                "\"+p"
                "paste from system clipboard"
              ]
              [
                "visual"
                "<leader>y"
                "\"+y"
                "copy to system clipboard"
              ]
            ];
          };
        };
      }

      {
        name = "telescope";
        opts.mappings = {
          find_files = "<leader><leader>";
          live_grep = "<leader>fg";
          simple_find_file = "<leader>ff";
          git_files = "<leader>fG";
          buffers = "<leader>fb";
          keymaps = "<leader>fk";
          mappings = "<leader>fm";
          help_tags = "<leader>fh";
          colorscheme = "<C-t>";
          quickfix = "<leader>fq";
        };
      }

      {
        name = "lsp";
        enabled = true;
        opts = {
          servers = {
            astro = { };
            bashls = { };
            cssls = { };
            # denols = {
            #   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            #   single_file_support = false,
            # };
            dockerls = { };
            emmet_language_server.filetypes = [
              "astro"
              "css"
              "eruby"
              "html"
              "javascript"
              "javascriptreact"
              "less"
              "sass"
              "scss"
              "pug"
              "typescriptreact"
            ];
            graphql.filetypes = [
              "graphql"
              "typescriptreact"
              "javascriptreact"
              "typescript"
            ];
            helm_ls = { };
            hls = { };
            html = { };
            intelephense = { };
            jqls = { };
            # jsonls.settings.json = {
            #   schemas = mkLuaInline "require('schemastore').json.schemas()";
            #   validate.enable = true;
            # };
            lua_ls.settings.Lua.diagnostics.globals = [ "vim" ];
            # ltex = {
            #   on_attach = mkLuaInline ''
            #     function()
            #       require("ltex_extra").setup({
            #         load_langs = { "en-US", "en-GB" },
            #         init_check = true,
            #         path = vim.fn.stdpath("data") .. "/dictionary",
            #       })
            #     end
            #   '';
            #   settings.ltex = {
            #     language = "en-US";
            #     additionalRules = {
            #       enablePickyRules = true;
            #       motherTongue = "en_GB";
            #     };
            #   };
            # };
            marksman = { };
            nil_ls = {
              autostart = true;
              cmd = [ "nil" ];
              settings = {
                "nil" = {
                  formatting.command = [ "nixfmt" ];
                  nix.maxMemoryMB = null;
                };
              };
            };
            nushell = { };
            serve_d = { };
            sourcekit = { };
            taplo = { };
            teal_ls = { };
            tailwindcss.filetypes = [
              "astro"
              "javascriptreact"
              "typescriptreact"
              "html"
              "css"
            ];
            volar = {
              capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true;
              # root_dir = mkLuaInline ''require("lspconfig.util").root_pattern("package.json")'';
            };
            # yamlls.settings = {
            #   yaml = {
            #     completion = true;
            #     validate = true;
            #     suggest.parentSkeletonSelectedFirst = true;
            #     schemas = mkLuaInline ''
            #       vim.tbl_extend("keep", {
            #         ["https://json.schemastore.org/github-action"] = ".github/action.{yaml,yml}",
            #         ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
            #         ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*lab-ci.{yaml,yml}",
            #         ["https://json.schemastore.org/helmfile"] = "helmfile.{yaml,yml}",
            #         ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
            #         ["https://goreleaser.com/static/schema.json"] = ".goreleaser.{yml,yaml}",
            #       }, require("schemastore").yaml.schemas())
            #     '';
            #   };
            #   redhat.telemetry.enabled = false;
            # };
          };
        };
      }

      {
        name = "treesitter";
        enabled = true;
        opts.config = {
          auto_install = false;
          highlight.enable = true;
          rainbow = {
            extended_mode = true;
            max_file_lines = 8192;
            additional_vim_regex_highlighting = false;
          };
        };
      }

      {
        name = "indent";
        opts.config.indent = {
          scope.enabled = true;
          highlight = "IblIndent";
        };
      }

      {
        name = "dash";
        opts = {
          header = [
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡇⠀⠀⠀⣿⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⢀⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣧⠀⠀⣸⣿⣿⢿⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⢀⣤⣭⡵⣾⡏⠀⣰⣿⣿⣿⣷⣾⡭⣽⣿⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⡄⠀⠀⢀⣴⣿⣿⣧⣀⣸⠃⣰⣿⣿⣿⣿⣿⣧⣀⣼⣿⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣆⠀⢾⣿⣿⣿⣿⣿⣿⣴⣿⣿⢿⣿⣿⣿⣿⣿⣿⣯⡀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⣿⣿⣦⣸⣿⣿⡟⠉⠛⢻⣿⣿⣿⣶⡉⡿⠏⣹⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⠇⡇⡅⡎⣿⣿⣿⣿⠇⣓⣊⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠒⣿⣿⣿⣍⠄⢧⣧⣿⡙⣿⣿⣫⣾⣿⣿⠿⣛⣥⠎⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣤⡈⠛⢿⣿⡧⠨⣿⣿⣿⣎⠛⠋⠩⣷⣆⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⣠⣴⣦⣄⠀⠀⠀⠀⠀⠈⠙⠓⣼⠋⠀⠂⠈⠻⠿⡿⠀⠀⢀⣈⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⢸⣿⡆⢀⣀⠲⢦⣤⣤⠄⣠⣄⣉⣙⠛⣡⡀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠘⠿⣡⣿⣿⣶⣤⣤⣤⡀⣿⣿⣿⣿⣿⣿⡧⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⢱⣿⣿⣿⡿⢿⣛⣀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⡗⣼⣿⣿⣿⣿⣿⣿⣿⣿⢇⣿⣿⢟⣭⣶⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⠟⣼⣿⣿⣿⣿⣿⣿⣿⣿⢏⡾⣫⣴⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⠃⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣡⣾⣿⣿⣿⣿⣿⣿⣿⡿⢹⣿⣿⣿⣿⣿⣆⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣿⣿⣿⣿⣿⡿⢏⣼⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⢿⣿⣿⣿⣿⣿⡄⠀⠀"
          ];
          buttons = [
            [
              "  New file"
              "n"
              "<cmd>ene <bar> startinsert <cr>"
            ]
            [
              "  Find file"
              "f"
              "<cmd>Telescope find_files<cr>"
            ]
            [
              "  Live grep"
              "g"
              "<cmd>Telescope live_grep<cr>"
            ]
            [
              "  Show sessions"
              "s"
              "<cmd>SessionManager load_session<cr>"
            ]
            [
              "  Projects"
              "p"
              "<cmd>Telescope project<CR>"
            ]
            [
              "  Quit"
              "q"
              "<cmd>qa<CR>"
            ]
          ];
        };
      }
    ];
  };

  plugins = {
    lspconfig.dependencies = {
      ltex-extra.src = srcs.ltex-extra;
      schemastore.src = srcs.schemastore;
    };

    "lazy.nvim".package = pkgs.vimPlugins.lazy-nvim;

    treesitter = {
      dependencies.rainbow-delimiters.src = srcs.rainbow-delimiters;
      package = (pkgs.callPackage ../pkgs/nvim-treesitter { }).override {
        grammars = [
          "astro"
          "bash"
          "c"
          "cpp"
          "css"
          "csv"
          "diff"
          "dockerfile"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
          "go"
          "gomod"
          "gosum"
          "gotmpl"
          "graphql"
          "haskell"
          "html"
          "javascript"
          "jsdoc"
          "json"
          "jsonc"
          "just"
          "lua"
          "make"
          "markdown"
          "markdown_inline"
          "nix"
          "nu"
          "php"
          "php_only"
          "python"
          "rust"
          "scss"
          "svelte"
          "toml"
          "tsv"
          "tsx"
          "typescript"
          "vim"
          "vue"
          "yaml"
          "yuck"
          "zig"
        ];
      };
    };
  };
}
