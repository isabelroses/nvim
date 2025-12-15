{
  lib,

  # path
  fd,
  ripgrep,
  emmet-language-server,
  vscode-langservers-extracted,
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
  copilot-language-server,
  inotify-tools,

  # builders n stuff
  stdenvNoCC,
  vimUtils,
  vimPlugins,
  fetchFromGitHub,

  # our beautiful wrapper
  wrapNeovim,

  # settings
  bundleLSPs ? true,
  bundleGrammars ? true,
  izvimVersion ? "unknown",
}:
let
  inherit (lib)
    flatten
    optionals
    flip
    getAttr
    ;

  # install our treesitter grammars
  grammars = map (flip getAttr vimPlugins.nvim-treesitter.grammarPlugins) [
    # keep-sorted start
    "bash"
    "c"
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
    "jsonc"
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
    "yaml"
    "yuck"
    # keep-sorted end
  ];
in
wrapNeovim {
  pname = "izvim";
  versionSuffix = izvimVersion;

  userConfig = ./config;

  startPlugins =
    (with vimPlugins; [
      # keep-sorted start
      lz-n
      lzn-auto-require
      nvim-lspconfig
      nvim-treesitter
      plenary-nvim
      # keep-sorted end
    ])
    ++ lib.optionals bundleGrammars grammars;

  optPlugins =
    with vimPlugins;
    [
      # keep-sorted start
      catppuccin-nvim
      gitsigns-nvim
      copilot-lua
      crates-nvim
      fidget-nvim
      formatter-nvim
      freeze-nvim
      cloak-nvim
      bufferline-nvim
      blink-cmp
      cord-nvim
      telescope-fzf-native-nvim
      harpoon2
      img-clip-nvim
      indent-blankline-nvim
      lazydev-nvim
      lsp-status-nvim
      lualine-nvim
      markview-nvim
      mini-icons
      mini-surround
      neo-tree-nvim
      nvim-colorizer-lua
      nvim-lint
      nvim-navic
      nui-nvim
      obsidian-nvim
      rainbow-delimiters-nvim
      rustaceanvim
      SchemaStore-nvim
      snacks-nvim
      todo-comments-nvim
      toggleterm-nvim
      trouble-nvim
      vim-fugitive
      vim-wakatime
      fzf-lua
      # keep-sorted end
    ]
    ++ [
      (vimPlugins.undotree.overrideAttrs (oa: {
        src = fetchFromGitHub {
          owner = "jiaoshijie";
          repo = "undotree";
          rev = "3976ed63d7fb0cc47f6a778e230a390a399df69c";
          hash = "sha256-rrsVgewhIMrJ1FioFTDejzXQMPslPeq3ntpEOBze/DI=";
        };
      }))

      (vimUtils.buildVimPlugin {
        pname = "nivvie-nvim";
        version = "2025.10.26";

        src = fetchFromGitHub {
          owner = "comfysage";
          repo = "nivvie.nvim";
          rev = "5ca4fe448f1281ddcf4fb131b159772dcb1a18d3";
          hash = "sha256-HQK0uXFjRVBdCzh3dHPxcu+kUAG00+fW2J6pe1qAwZM=";
        };
      })
    ];

  extraPackages = flatten [
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

      # Markdown / latex
      harper
      marksman

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
      copilot-language-server
    ])

    (optionals stdenvNoCC.hostPlatform.isLinux [
      inotify-tools # for file watching, the defaults kinda slow
    ])
  ];
}
