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
  nixfmt,
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
  bundleLSPs ? true,
  bundleGrammars ? true,
  izvimPlugins,
  izvimVersion ? "unknown",
}:
let
  inherit (lib)
    pipe
    isDerivation
    flatten
    optionals
    attrValues
    filter
    flip
    getAttr
    partition
    ;

  partionPlugins =
    plugins:
    let
      parts = partition (elem: elem.passthru.start or false) plugins;
    in
    {
      start = parts.right;
      opt = parts.wrong;
    };

  patrionedPlugins = pipe izvimPlugins [
    attrValues
    (filter isDerivation)
    partionPlugins
  ];

  # install our treesitter grammars
  grammars = map (flip getAttr vimPlugins.nvim-treesitter.grammarPlugins) [
    # keep-sorted start
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
    "latex"
    "lua"
    "make"
    "markdown"
    "markdown_inline"
    "nix"
    "nu"
    "php"
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

  userConfig = ../../config;

  optPlugins = patrionedPlugins.opt ++ [
    # extra plugins because they often fail or need extra steps
    vimPlugins.blink-cmp
    vimPlugins.cord-nvim
    vimPlugins.telescope-fzf-native-nvim
  ];

  startPlugins = patrionedPlugins.start ++ lib.optionals bundleGrammars grammars;

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
    ])

    (optionals stdenvNoCC.hostPlatform.isLinux [
      inotify-tools # for file watching, the defaults kinda slow
    ])

    (optionals (bundleLSPs && stdenvNoCC.hostPlatform.isDarwin) [
      copilot-language-server
    ])
    (optionals (bundleLSPs && stdenvNoCC.hostPlatform.isLinux) [
      copilot-language-server-fhs
    ])
  ];
}
