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
    config = ./obsidian-nvim.lua;
    dependencies = {inherit plenary;};
  };

  markdown-preview = {
    package = pkgs.callPackage ../pkgs/markdown-preview {};
  };

  vim-table-mode = {
    src = srcs.vim-table-mode;
    config = ./vim-table-mode.lua;
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

  # tabs
  # bufferline = {
  #   src = srcs.bufferline;
  #   config = ./bufferline.lua;
  #   dependencies = {inherit catppuccin;};
  # };

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

  color-picker = {
    src = srcs.color-picker;
    config = true;
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

  # formating
  indent-blankline = {
    src = srcs.indent-blankline;
    config = ./indent-blankline.lua;
  };

  # quicker movement
  nvim-surround = {
    src = srcs.nvim-surround;
    config = true;
  };

  spectre = {
    src = srcs.nvim-spectre;
    config.replace_engine.sed.cmd = "sed";
    dependencies = {inherit plenary;};
  };

  telescope = {
    src = srcs.telescope;
    config = ./telescope.lua;
    dependencies = {
      inherit plenary nvim-web-devicons;
      telescope-asynctasks.src = srcs.telescope-asynctasks;
      telescope-file-browser.src = srcs.telescope-file-browser;
      telescope-fzf-native.package = pkgs.callPackage ../pkgs/telescope-fzf-native {};
      telescope-project.src = srcs.telescope-project;
      telescope-ui-select.src = srcs.telescope-ui-select;
    };
  };

  harpoon = {
    src = srcs.harpoon;
    config = ./harpoon.lua;
    dependencies = {
      inherit plenary telescope;
    };
  };

  # copilot
  copilot-cmp.src = srcs.copilot-cmp;

  copilot-lua = {
    src = srcs.copilot-lua;
    config = {
      panel = {
        enabled = true;
        auto_refresh = false;
        keymap = {
          jump_prev = "[[";
          jump_next = "]]";
          accept = "<CR>";
          refresh = "gr";
          open = "<M-CR>";
        };
        layout = {
          position = "bottom";
          ratio = 0.4;
        };
      };
      suggestion = {
        enabled = true;
        auto_trigger = false;
        debounce = 75;
        keymap = {
          accept = "<M-l>";
          accept_word = false;
          accept_line = false;
          next = "<M-]>";
          prev = "<M-[>";
          dismiss = "<C-]>";
        };
      };
      filetypes = {
        yaml = true;
        markdown = true;
        help = false;
        gitcommit = false;
        gitrebase = false;
        hgcommit = false;
        svn = false;
        cvs = false;
        "." = false;
      };
      copilot_node_command = "node";
      server_opts_overrides = {};
    };
  };

  # git stuff
  diffview.src = srcs.diffview;

  gitsigns = {
    src = srcs.gitsigns;
    config = ./gitsigns.lua;
    dependencies = {inherit which-key;};
  };

  lazygit = {
    src = srcs.lazygit;
    dependencies = {inherit plenary;};
  };

  # lsp
  nvim-treesitter = {
    package = pkgs.callPackage ../pkgs/nvim-treesitter {};
    config = ./tree-sitter.lua;

    dependencies = {
      nvim-treesitter-playground.src = srcs.playground;
      nvim-treesitter-textobjects.src = srcs.nvim-treesitter-textobjects;
      nvim-ts-autotag.src = srcs.nvim-ts-autotag;
      rainbow-delimiters.src = srcs.rainbow-delimiters;

      nvim-treesitter-context = {
        src = srcs.nvim-treesitter-context;
        config = {
          enable = false;
          mode = "topline";
        };
      };
    };
  };

  nvim-lspconfig = {
    src = srcs.nvim-lspconfig;
    config = ./lsp.lua;

    dependencies = rec {
      cmp.src = srcs.nvim-cmp;
      cmp-buffer.src = srcs.cmp-buffer;
      cmp-cmdline.src = srcs.cmp-cmdline;
      cmp-nvim-lsp.src = srcs.cmp-nvim-lsp;
      cmp-path.src = srcs.cmp-path;
      cmp_luasnip.src = srcs.cmp_luasnip;
      cmp-git.src = srcs.cmp-git;
      lspkind.src = srcs.lspkind;
      null-ls.src = srcs.null-ls;
      lsp-status.src = srcs.lsp-status;
      ltex-extra.src = srcs.ltex-extra;
      schemastore.src = srcs.schemastore;
      py_lsp.src = srcs.py_lsp;
      rust-tools.src = srcs.rust-tools;
      typescript-tools.src = srcs.typescript-tools;
      neorepl.src = srcs.neorepl;
      neoconf.src = srcs.neoconf;

      luasnip = {
        src = srcs.luasnip;
        dependencies = {
          friendly-snippets.src = srcs.friendly-snippets;
          my-snippets.src = pkgs.callPackage ../pkgs/snippets {};
        };
      };

      trouble = {
        src = srcs.trouble;
        config.padding = false;
      };

      neodev = {
        src = srcs.neodev;
        config = true;
      };

      nvim-autopairs = {
        src = srcs.nvim-autopairs;
        config = ./autopairs.lua;
        dependencies = {inherit cmp;};
      };

      crates = {
        src = srcs.crates;
        config = true;
      };

      go-nvim = {
        src = srcs.go-nvim;
        dependencies = {
          guihua-lua.src = srcs.guihua-lua;
        };
      };

      nvim-dap = {
        src = srcs.nvim-dap;
        dependencies = {
          nvim-dap-ui.src = srcs.nvim-dap-ui;
          nvim-dap-virtual-text.src = srcs.nvim-dap-virtual-text;
        };
      };
    };
  };

  # misc
  wakatime.src = pkgs.vimPlugins.vim-wakatime; # track my time coding
  dressing.src = srcs.dressing;

  glance = {
    src = srcs.glance;
    config = true;
  };

  # deps
  plenary.src = srcs.plenary;
  asyncrun-vim.src = srcs.asyncrun-vim;
  asynctasks-vim.src = srcs.asynctasks-vim;

  nvim-web-devicons = {
    src = srcs.nvim-web-devicons;
    config = ./nvim-web-devicons.lua;
    dependencies = {inherit catppuccin;};
  };
}
