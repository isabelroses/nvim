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
  obsidian-headless,

  # builders n stuff
  stdenvNoCC,
  vimUtils,
  vimPlugins,
  fetchFromGitHub,

  # our beautiful wrapper
  wrapNeovim,

  # settings
  bundleLSPs ? true,
}:
let
  inherit (lib.lists) concatLists concatMap optionals;
  inherit (lib.attrsets) attrValues getAttrs;

  grammars = [
    # keep-sorted start
    "bash"
    "c"
    "comment"
    "cpp"
    "css"
    "csv"
    "dhall"
    "diff"
    "dockerfile"
    "git_rebase"
    "gitattributes"
    "gitcommit"
    "gitignore"
    "gleam"
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
    "just"
    "latex"
    "lua"
    "make"
    "markdown"
    "markdown_inline"
    "nix"
    "nu"
    "php"
    "purescript"
    "python"
    "qmldir"
    "qmljs"
    "toml"
    "tsx"
    "typescript"
    "typst"
    "yaml"
    "yuck"
    # keep-sorted end
  ];

  parsers = vimPlugins.nvim-treesitter.parsers // {
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

  grammars-queries = concatMap (drv: [
    drv
    drv.associatedQuery
  ]) (attrValues (getAttrs grammars parsers));
in
wrapNeovim {
  pname = "izvim";

  cleanRuntimePath = true;
  # needed for https://neovim.io/doc/user/options/#'exrc'
  additionalRuntimePaths = [ ".nvim" ];

  userConfig = ./config;

  startPlugins =
    grammars-queries
    ++ attrValues {
      inherit (vimPlugins)
        # keep-sorted start
        lz-n
        nvim-lspconfig
        plenary-nvim
        # keep-sorted end
        ;
    };

  optPlugins = attrValues {
    inherit (vimPlugins)
      # keep-sorted start
      SchemaStore-nvim
      blink-cmp
      bufferline-nvim
      catppuccin-nvim
      cloak-nvim
      conform-nvim
      cord-nvim
      crates-nvim
      dropbar-nvim
      freeze-nvim
      fzf-lua
      gitsigns-nvim
      grug-far-nvim
      harpoon2
      img-clip-nvim
      markview-nvim
      mini-hipatterns
      mini-icons
      mini-surround
      nvim-colorizer-lua
      nvim-lint
      nvim-treesitter-context
      obsidian-nvim
      rainbow-delimiters-nvim
      rustaceanvim
      snacks-nvim
      typst-preview-nvim
      vim-wakatime
      # keep-sorted end
      ;

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
      obsidian-headless
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
