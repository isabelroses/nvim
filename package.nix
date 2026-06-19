{
  lib,

  # path
  fd,
  ripgrep,
  emmet-language-server,
  vscode-langservers-extracted,
  mdx-language-server,
  harper,
  marksman,
  nil,
  statix,
  deadnix,
  nixfmt,
  shfmt,
  shellcheck,
  bash-language-server,
  proselint,
  taplo,
  yaml-language-server,
  lazygit,
  inotify-tools,
  tinymist,

  # builders n stuff
  stdenvNoCC,
  vimUtils,
  vimPlugins,
  fetchFromGitHub,
  catppuccin-whiskers,

  # our beautiful wrapper
  wrapNeovim,

  # settings
  bundleLSPs ? true,
}:
let
  inherit (lib.lists) concatLists optionals;
  inherit (lib.attrsets) attrValues mapAttrs' nameValuePair;

  grammars = {
    inherit (vimPlugins.nvim-treesitter.parsers)
      # keep-sorted start
      bash
      c
      comment
      cpp
      css
      csv
      dhall
      diff
      dockerfile
      git_rebase
      gitattributes
      gitcommit
      gitignore
      gleam
      go
      gomod
      gosum
      gotmpl
      graphql
      haskell
      html
      javascript
      jsdoc
      json
      just
      latex
      lua
      make
      markdown
      markdown_inline
      nu
      php
      purescript
      python
      qmldir
      qmljs
      toml
      tsx
      typescript
      typst
      yaml
      yuck
      # keep-sorted end
      ;

    nix = vimPlugins.nvim-treesitter.parsers.nix.overrideAttrs (_: {
      version = "0.0.0+rev=4a14c6";

      src = fetchFromGitHub {
        owner = "numtide";
        repo = "tree-sitter-nix";
        rev = "4a14c6732e5173431d6ef4ccd7cd6f6f9f7966bf";
        hash = "sha256-CEwM39kEIW/24QpOWJp3bXb56YL1CZs1NDksKvJreCI=";
      };
    });
  };

  # we have to rename these otherwise they clash with the grammars
  queries = mapAttrs' (n: p: nameValuePair "queries-${n}" p.associatedQuery) grammars;
in
wrapNeovim {
  pname = "izvim";

  cleanRuntimePath = true;
  # needed for https://neovim.io/doc/user/options/#'exrc'
  additionalRuntimePaths = [ ".nvim" ];

  userConfig = ./config;

  startPlugins = attrValues (
    grammars
    // queries
    // {
      inherit (vimPlugins)
        # keep-sorted start
        lz-n
        lzn-auto-require
        nvim-lspconfig
        plenary-nvim
        # keep-sorted end
        ;
    }
  );

  optPlugins = attrValues {
    inherit (vimPlugins)
      # keep-sorted start
      SchemaStore-nvim
      blink-cmp
      bufferline-nvim
      cloak-nvim
      conform-nvim
      cord-nvim
      crates-nvim
      fidget-nvim
      freeze-nvim
      fzf-lua
      gitsigns-nvim
      grug-far-nvim
      harpoon2
      img-clip-nvim
      indent-blankline-nvim
      lazydev-nvim
      lualine-nvim
      markview-nvim
      mini-icons
      mini-surround
      neo-tree-nvim
      nui-nvim
      nvim-colorizer-lua
      nvim-lint
      nvim-navic
      nvim-treesitter-context
      obsidian-nvim
      rainbow-delimiters-nvim
      rustaceanvim
      snacks-nvim
      telescope-fzf-native-nvim
      todo-comments-nvim
      toggleterm-nvim
      trouble-nvim
      typst-preview-nvim
      vim-wakatime
      # keep-sorted end
      ;

    catppuccin-nvim = vimPlugins.catppuccin-nvim.overrideAttrs (oa: {
      nativeBuildInputs = [ catppuccin-whiskers ];

      buildPhase = ''
        whiskers nvim.tera \
          --color-overrides ${
            lib.escapeShellArg (
              builtins.toJSON {
                mocha = {
                  base = "000000";
                  mantle = "010101";
                  crust = "020202";
                };
              }
            )
          }
      '';
    });

    undotree = vimPlugins.undotree.overrideAttrs (oa: {
      src = fetchFromGitHub {
        owner = "jiaoshijie";
        repo = "undotree";
        rev = "3976ed63d7fb0cc47f6a778e230a390a399df69c";
        hash = "sha256-rrsVgewhIMrJ1FioFTDejzXQMPslPeq3ntpEOBze/DI=";
      };
    });

    nivvie-nvim = vimUtils.buildVimPlugin {
      pname = "nivvie-nvim";
      version = "2025.10.26";

      src = fetchFromGitHub {
        owner = "comfysage";
        repo = "nivvie.nvim";
        rev = "1c94acc01b090ff1775956622ee6d7292f7dd84c";
        hash = "sha256-n65wXJrw9yxNI7ieZFX5On9qmsBVDxzVK17HJnRss3k=";
      };
    };
  };

  extraPackages = concatLists [
    [
      # external deps
      fd
      ripgrep
      lazygit
    ]

    (optionals bundleLSPs [
      # web dev
      emmet-language-server
      vscode-langservers-extracted
      mdx-language-server

      # Markdown / latex / typst
      harper
      marksman
      tinymist

      # nix
      nil
      statix
      deadnix
      nixfmt

      # shell
      shfmt
      shellcheck
      bash-language-server

      # etc.
      proselint
      taplo # toml
      yaml-language-server # yaml
    ])

    (optionals stdenvNoCC.hostPlatform.isLinux [
      inotify-tools # for file watching, the defaults kinda slow
    ])
  ];
}
