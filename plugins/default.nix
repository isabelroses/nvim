{pkgs}: let
  srcs = builtins.mapAttrs (_: pkg: pkg.src) (pkgs.callPackage ../_sources/generated.nix {});
in rec {
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
    dependencies = {inherit plenary nvim-web-devicons;};
  };

  # terminal within nvim
  toggleterm = {
    src = srcs.toggleterm;
    config = {
      open_mapping = "<C-t>";
      shade_terminals = false;
    };
  };

  # markdown stuff
  obsidian-nvim = {
    src = srcs.obsidian-nvim;
    config = ./obsidian.lua;
    dependencies = {inherit plenary;};
  };

  # rice
  alpha = {
    src = srcs.alpha-nvim;
    config = ./alpha.lua;
    dependencies = {
      neovim-session-manager = {
        src = srcs.neovim-session-manager;
        dependencies = {inherit plenary;};
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

        dependencies = {inherit nvim-web-devicons;};
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

    config = {
      text = {
        spinner = "dots";
        done = "󰗡";
        commenced = "init";
        completed = "done";
      };
      window.blend = 0;
      sources = {
        "copilot".ignore = true;
        "null-ls".ignore = true;
      };
    };
  };

  # nicer notfications
  notify = {
    src = srcs.nvim-notify;
    config = ./notify.lua;
    lazy = false;
  };

  nvim-colorizer = {
    src = srcs.nvim-colorizer-lua;
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
        sass = {enable = true;};
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

  # comments
  comment = {
    src = srcs.comment;
    config = true;
  };

  todo-comments = {
    src = srcs.todo-comments;
    config = true;
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
  };

  # lsp
  nvim-treesitter = {
    package = pkgs.callPackage ../pkgs/nvim-treesitter {};
    config = ./tree-sitter.lua;

    dependencies = {
      rainbow-delimiters.src = srcs.rainbow-delimiters;
    };
  };

  # rust lsp
  rustaceanvim = {
    src = srcs.rustaceanvim;
    config = ./rust.lua;
    ft = "rust";
    dependencies = {
      inherit which-key;
    };
  };

  # tailwind but better
  tailwind-tools = {
    src = srcs.tailwind-tools;
    config = ./tailwind.lua;
  };

  nvim-lspconfig = {
    src = srcs.nvim-lspconfig;
    config = ./lsp.lua;

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

      luasnip = {
        src = srcs.luasnip;
        dependencies = {
          my-snippets.src = pkgs.callPackage ../pkgs/snippets {};
        };
      };

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
      };

      go-nvim = {
        src = srcs.go-nvim;
        paths = [pkgs.repos.nekowinston.gonvim-tools];
        dependencies = {
          guihua-lua.src = srcs.guihua-lua;
        };
      };
    };
  };

  # hide my secrets
  cloak = {
    src = srcs.cloak;
    config = ./cloak.lua;
  };

  # misc
  undotree.src = srcs.undotree; # undo tree

  wakatime = {
    src = pkgs.vimPlugins.vim-wakatime; # track my time coding
    paths = [pkgs.wakatime];
  };

  direnv = {
    src = srcs.direnv-vim; # direnv integration
    paths = [pkgs.direnv];
  };

  nvim-silicon = {
    src = srcs.nvim-silicon;
    paths = [pkgs.silicon];
    config = ./silicon.lua;
  };

  # lazygit integration
  lazygit = {
    src = srcs.lazygit;
    dependencies = {inherit plenary;};
    paths = [pkgs.lazygit];
  };

  # deps
  plenary.src = srcs.plenary;

  nvim-web-devicons = {
    src = srcs.nvim-web-devicons;
    config = ./nvim-web-devicons.lua;
    dependencies = {inherit catppuccin;};
  };
}
