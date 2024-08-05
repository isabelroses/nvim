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

  # markdown stuff
  obsidian-nvim = {
    src = srcs.obsidian-nvim;
    config = ./obsidian.lua;
    event = "BufRead .obsidian";
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
    enabled = ''
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

      neodev = {
        src = srcs.neodev;
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
    enabled = ''
      function()
        return vim.fn.glob("~/.wakatime.cfg") ~= "" or vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= ""
      end
    '';
    src = pkgs.vimPlugins.vim-wakatime;
    event = "VeryLazy";
    paths = [ pkgs.wakatime ];
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
  lazygit = {
    src = srcs.lazygit;
    event = "VeryLazy";
    dependencies = {
      inherit plenary;
    };
    paths = [ pkgs.lazygit ];
  };

  # discord integration
  neocord = {
    src = srcs.neocord;
    event = "VeryLazy";
    config = {
      logo = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp";
      main_image = "logo";
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
