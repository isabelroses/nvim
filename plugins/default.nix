{ pkgs }:
let
  srcs = builtins.mapAttrs (_: pkg: pkg.src) (pkgs.callPackage ../_sources/generated.nix { });
in
rec {
  config = {
    src = ../config;
    lazy = false;
    priority = 1000;
  };

  # tree view
  nvim-tree = {
    src = srcs.nvim-tree-lua;
    event = "VeryLazy";
    config = {
      sync_root_with_cwd = true;
      diagnostics.enable = true;
      renderer.indent_markers.enable = true;
      modified.enable = true;
      renderer.icons.web_devicons.folder.enable = true;
    };
    dependencies = {
      inherit plenary nvim-web-devicons;
    };
  };

  # mini
  mini-surround = {
    src = srcs.mini-surround;
    main = "mini.surround";
    event = "InsertEnter";
    config.mappings = {
      add = "S"; # Add surrounding in Normal and Visual modes
      delete = "ds"; # Delete surrounding
      find = "sf"; # Find surrounding (to the right)
      find_left = "sF"; # Find surrounding (to the left)
      highlight = "sh"; # Highlight surrounding
      replace = "cs"; # Replace surrounding
      update_n_lines = "sn"; # Update `n_lines`
      suffix_last = ""; # Suffix to search with "prev" method
      suffix_next = ""; # Suffix to search with "next" method
    };
  };

  # markdown stuff
  markview = {
    src = srcs.markview;
    config = ./markview.lua;
    lazy = false; # it handles lazy loading itself
    dependencies = {
      inherit nvim-web-devicons;
    };
  };

  obsidian-nvim = {
    src = srcs.obsidian-nvim;
    config = ./obsidian.lua;
    dependencies = {
      inherit plenary;
    };
  };

  # rice
  alpha = {
    src = srcs.alpha-nvim;
    config = ./alpha.lua;
    dependencies = {
      neovim-session-manager = {
        src = srcs.neovim-session-manager;
        dependencies = {
          inherit plenary;
        };
      };
    };
  };

  lualine = {
    src = srcs.lualine;
    config = ./lualine.lua;
    dependencies = {
      navic = {
        src = srcs.nvim-navic;

        config = {
          highlight = true;
          separator = " ";
          icons = {
            File = " ";
            Module = " ";
            Namespace = " ";
            Package = " ";
            Class = " ";
            Method = " ";
            Property = " ";
            Field = " ";
            Constructor = " ";
            Enum = " ";
            Interface = " ";
            Function = " ";
            Variable = " ";
            Constant = " ";
            String = " ";
            Number = " ";
            Boolean = " ";
            Array = " ";
            Object = " ";
            Key = " ";
            Null = " ";
            EnumMember = " ";
            Struct = " ";
            Event = " ";
            Operator = " ";
            TypeParameter = " ";
          };
        };

        dependencies = {
          inherit nvim-web-devicons;
        };
      };
    };
  };

  catppuccin = {
    src = srcs.catppuccin;
    config = ./catppuccin.lua;
    priority = 1000;
  };

  # evergarden = {
  #   src = srcs.evergarden;
  #   config = ./evergarden.lua;
  #   priority = 1000;
  # };

  fidget = {
    src = srcs.fidget;
    event = "VeryLazy";

    config = {
      display.done_icon = "󰗡";
      notification = {
        override_vim_notify = true;
        window.winblend = 0;
      };
      progress.ignore = [
        "copilot"
        "null-ls"
      ];
    };
  };

  nvim-colorizer = {
    src = srcs.nvim-colorizer-lua;
    event = "VeryLazy";

    config = {
      user_default_options = {
        RGB = true;
        RRGGBB = true;
        names = false;
        RRGGBBAA = true;
        AARRGGBB = false;
        rgb_fn = false;
        hsl_fn = false;
        css = false;
        css_fn = false;
        mode = "background";
        tailwind = "both";
        sass = {
          enable = true;
        };
        virtualtext = " ";
      };

      buftypes = [
        "*"
        "!dashboard"
        "!lazy"
        "!popup"
        "!prompt"
      ];
    };
  };

  todo-comments = {
    src = srcs.todo-comments;
    config = true;
    event = "VeryLazy";
  };

  # quicker movement
  telescope = {
    src = srcs.telescope;
    config = ./telescope.lua;
    dependencies = {
      inherit plenary nvim-web-devicons;
      telescope-fzf-native.package = pkgs.vimPlugins.telescope-fzf-native-nvim;
      telescope-project.src = srcs.telescope-project;
      telescope-ui-select.src = srcs.telescope-ui-select;
    };
  };

  harpoon = {
    src = srcs.harpoon;
    config = ./harpoon.lua;
    dependencies = {
      inherit plenary;
    };
  };

  # copilot
  # copilot-cmp.src = srcs.copilot-cmp;
  copilot-lua = {
    src = srcs.copilot-lua;
    enabled = # lua
      ''
        function()
          return vim.fn.glob("~/.config/gh/config.yml") ~= "" or vim.fn.glob("$XDG_CONFIG_HOME/gh/config.yml") ~= ""
        end
      '';
    config = ./copilot.lua;
    event = "InsertEnter";
  };

  # lsp
  nvim-treesitter = {
    config = ./tree-sitter.lua;
    event = "VeryLazy";
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

  # rust lsp + formmating
  rustaceanvim = {
    src = srcs.rustaceanvim;
    config = ./rust.lua;
    ft = "rust";
  };

  nvim-lspconfig = {
    src = srcs.nvim-lspconfig;
    config = ./lsp.lua;

    event = "VeryLazy";
    dependencies = {
      # inherit copilot-cmp;
      cmp.src = srcs.nvim-cmp;
      cmp-buffer.src = srcs.cmp-buffer;
      cmp-cmdline.src = srcs.cmp-cmdline;
      cmp-nvim-lsp.src = srcs.cmp-nvim-lsp;
      cmp-path.src = srcs.cmp-path;
      cmp_luasnip.src = srcs.cmp_luasnip;
      lspkind.src = srcs.lspkind;
      null-ls.src = srcs.null-ls;
      lsp-status.src = srcs.lsp-status;
      ltex-extra.src = srcs.ltex-extra;
      schemastore.src = srcs.schemastore;
      py_lsp.src = srcs.py_lsp;
      typescript-tools.src = srcs.typescript-tools;
      luasnip.src = srcs.luasnip;

      trouble = {
        src = srcs.trouble;
        config = ./trouble.lua;
      };

      lazydev = {
        src = srcs.lazydev;
        config = true;
      };

      crates = {
        src = srcs.crates;
        config = true;
        event = "BufRead Cargo.toml";
      };

      go-nvim = {
        src = srcs.go-nvim;
        event = "CmdlineEnter";
        ft = [
          "go"
          "gomod"
          "gosum"
          "gotmpl"
          "gohtmltmpl"
          "gotexttmpl"
        ];
        paths = [ pkgs.gonvim-tools ];
        dependencies.guihua-lua.src = srcs.guihua-lua;
      };
    };
  };

  # hide my secrets
  cloak = {
    src = srcs.cloak;
    event = "VeryLazy";
    config = ./cloak.lua;
  };

  # misc
  undotree = {
    src = srcs.undotree;
    event = "VeryLazy";
    config = ''
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    '';
  };

  # track my time coding
  wakatime = {
    enabled = # lua
      ''
        function()
          return vim.fn.glob("~/.wakatime.cfg") ~= "" or vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= ""
        end
      '';
    src = srcs.wakatime;
    event = "VeryLazy";
    paths = [ pkgs.wakatime-cli ];
  };

  ibl = {
    src = srcs.indent-blankline;
    main = "ibl";
    config = {
      scope.enabled = false;
      exclude.filetypes = [
        "alpha"
        "fugitive"
        "help"
        "lazy"
        "NvimTree"
        "ToggleTerm"
        "LazyGit"
        "TelescopePrompt"
        "prompt"
        "code-action-menu-menu"
        "code-action-menu-warning-message"
        "Trouble"
      ];
    };
  };

  # cool snippets saving
  sayama-nvim = {
    src = srcs.sayama-nvim;
    event = "VeryLazy";
    config.dir = "$XDG_DATA_HOME/zzz";
  };

  freeze = {
    src = srcs.freeze-nvim;
    paths = [ pkgs.charm-freeze ];
    lazy = true;
    config = ./freeze.lua;
  };

  # lazygit integration
  toggleterm = {
    src = srcs.toggleterm-nvim;
    event = "VeryLazy";
    paths = [ pkgs.lazygit ];
    config = # lua
      ''
        function()
          require("toggleterm").setup()

          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            on_open = function(t)
              vim.keymap.set('t', 'q', vim.cmd.close, {buffer = t.bufnr, silent = true})
            end,
            float_opts = {
              border = "rounded",
            },
          })

          vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, {noremap = true, silent = true})
          vim.keymap.set("n", "<c-t>", "<cmd>ToggleTerm<cr>", {noremap = true, silent = true})
        end
      '';
  };

  direnv = {
    src = srcs.direnv-nvim;
    enabled = # lua
      ''
        function()
          return vim.fn.executable("direnv") == 1
        end
      '';
    config = # lua
      ''
        function()
          require("direnv").setup({
            autoload_direnv = true,
          })
        end
      '';
  };

  # discord integration
  cord = {
    src = pkgs.vimPlugins.cord-nvim;
    event = "VeryLazy";
    config = {
      editor.image = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp";
      display.swap_icons = true; # place the editor image as the main image
    };
  };

  # deps
  plenary.src = srcs.plenary;

  nvim-web-devicons = {
    src = srcs.nvim-web-devicons;
    config = ./nvim-web-devicons.lua;
    event = "VeryLazy";
  };
}
