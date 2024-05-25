{ pkgs }:
let
  srcs = builtins.mapAttrs (_: pkg: pkg.src) (pkgs.callPackage ../_sources/generated.nix { });
in
rec {
  config = {
    src = ./config;
    lazy = false;
    priority = 1000;
  };

  # what was that button again
  which-key = {
    src = srcs.which-key;
    config = ./which-key.lua;
  };

  # tree view
  nvim-tree = {
    src = srcs.nvim-tree-lua;
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
      inherit plenary nvim-web-devicons which-key;
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
    config = ./copilot.lua;
    event = "InsertEnter";
  };

  # lsp
  nvim-treesitter = {
    package = pkgs.callPackage ../pkgs/nvim-treesitter { };
    config = ./tree-sitter.lua;
    event = "VeryLazy";

    dependencies = {
      rainbow-delimiters.src = srcs.rainbow-delimiters;
      tree-sitter-nu.src = srcs.tree-sitter-nu;
    };
  };

  # rust lsp + formmating
  rustaceanvim = {
    src = srcs.rustaceanvim;
    config = ./rust.lua;
    ft = "rust";
    dependencies = {
      inherit which-key;
    };
  };
  rust-vim = {
    src = srcs.rust-vim;
    ft = "rust";
  };

  nvim-lspconfig = {
    src = srcs.nvim-lspconfig;
    config = ''
      function()
        require("isabel.lsp")
      end
    '';

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
        ];
        paths = [ pkgs.nekowinston.gonvim-tools ];
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
  undotree.src = srcs.undotree; # undo tree
  vim-just.src = srcs.vim-just; # justfile support

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

  # indent-blankline = {
  #   src = srcs.indent-blankline;
  #   main = "ibl";
  #   config.exclude.filetypes = [
  #     "alpha"
  #     "fugitive"
  #     "help"
  #     "lazy"
  #     "NvimTree"
  #     "LazyGit"
  #     "TelescopePrompt"
  #     "prompt"
  #     "code-action-menu-menu"
  #     "code-action-menu-warning-message"
  #     "Trouble"
  #   ];
  #   event = "VeryLazy";
  # };

  charm-freeze = {
    src = srcs.charm-freeze-nvim;
    paths = [ pkgs.charm-freeze ];
    event = "VeryLazy";
    config = ./charm-freeze.lua;
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

  # deps
  plenary.src = srcs.plenary;

  nvim-web-devicons = {
    src = srcs.nvim-web-devicons;
    config = ./nvim-web-devicons.lua;
    event = "VeryLazy";
    dependencies = {
      inherit catppuccin;
    };
  };
}
