{
  lib,

  # get extra plugins we don't want to build
  vimPlugins,

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
  nixfmt-rfc-style,
  shfmt,
  shellcheck,
  bash-language-server,
  proselint,
  taplo,
  yaml-language-server,
  lazygit,
  copilot-language-server,
  copilot-language-server-fhs,
  inotify-tools,

  stdenvNoCC,

  # our beautiful wrapper
  wrapNeovim,

  # settings
  includePerLanguageTooling ? true,
  izvimPlugins,
  izvimVersion ? "unknown",

  nvim-treesitter,
  treesitter-grammars ? null,
}:
let
  inherit (lib)
    pipe
    isDerivation
    flatten
    optionals
    concatLists
    ;
  inherit (builtins) attrValues filter;

  izvimFilteredPlugins = pipe izvimPlugins [
    attrValues
    (filter isDerivation)
  ];

  grammars =
    if treesitter-grammars == null then
      [
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
        "latex"
        "make"
        "markdown"
        "markdown_inline"
        "nix"
        "nu"
        "php"
      ]
    else
      treesitter-grammars;
in
wrapNeovim {
  pname = "izvim";
  versionSuffix = izvimVersion;

  userConfig = ../../config;

  plugins = flatten [
    izvimFilteredPlugins

    (nvim-treesitter.override { inherit grammars; })

    # extra plugins because they often fail or need extra steps
    vimPlugins.blink-cmp
    vimPlugins.cord-nvim
    vimPlugins.telescope-fzf-native-nvim
  ];

  extraPackages = concatLists [
    [
      # external deps
      fd
      ripgrep
      lazygit
    ]

    (optionals includePerLanguageTooling [
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
      nixfmt-rfc-style

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

    (optionals (includePerLanguageTooling && stdenvNoCC.hostPlatform.isDarwin) [
      copilot-language-server
    ])
    (optionals (includePerLanguageTooling && stdenvNoCC.hostPlatform.isLinux) [
      copilot-language-server-fhs
    ])
  ];
}
