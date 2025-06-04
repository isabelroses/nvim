{
  lib,

  # get extra plugins we don't want to build
  vimPlugins,

  # path
  fd,
  ripgrep,
  stylua,
  lua-language-server,
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
  nodePackages,
  copilot-language-server,
  copilot-language-server-fhs,
  inotify-tools,

  stdenvNoCC,

  # our beautiful wrapper
  wrapNeovim,

  # settings
  includePerLanguageTooling ? true,
  izvimPlugins,

  nvim-treesitter,
  treesitter ? nvim-treesitter.override {
    grammars = [
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
      "php_only"
      "python"
      "rust"
      "scss"
      "tera"
      "toml"
      "tsv"
      "tsx"
      "typescript"
      "vue"
      "yaml"
      "yuck"
      "zig"
    ];
  },
}:
let

  inherit (lib)
    pipe
    isDerivation
    flatten
    optionals
    ;
  inherit (builtins) attrValues filter;

  izvimFilteredPlugins = pipe izvimPlugins [
    attrValues
    (filter isDerivation)
  ];
in
wrapNeovim {
  pname = "izvim";

  userConfig = ../../config;

  plugins = flatten [
    izvimFilteredPlugins

    treesitter

    # extra plugins because they often fail or need extra steps
    vimPlugins.blink-cmp
    vimPlugins.cord-nvim
    vimPlugins.telescope-fzf-native-nvim
  ];

  extraPackages =
    [
      # external deps
      fd
      ripgrep
      lazygit
      inotify-tools # for file watching, the defaults kinda slow
    ]
    ++ optionals includePerLanguageTooling [
      # lua
      stylua
      lua-language-server

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
      nodePackages.prettier
      proselint
      taplo # toml
      yaml-language-server # yaml
    ]
    ++ optionals stdenvNoCC.hostPlatform.isDarwin [ copilot-language-server ]
    ++ optionals stdenvNoCC.hostPlatform.isLinux [ copilot-language-server-fhs ];
}
