{
  lib,
  callPackage,

  # get extra plugins we don't want to build
  vimPlugins,

  # path
  fd,
  ripgrep,
  stylua,
  lua-language-server,
  emmet-language-server,
  vscode-langservers-extracted,
  ltex-ls-plus,
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

  # our beatiful wrapper
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
  inherit (lib.lists) flatten optionals;
  inherit (builtins) attrValues removeAttrs;
in
wrapNeovim {
  pname = "izvim";

  userConfig = ../../config;

  plugins = flatten [
    (attrValues (
      removeAttrs izvimPlugins [
        "override"
        "overrideDerivation"
      ]
    ))

    treesitter

    # extra plugsns beacuse they often fail or need extra steps
    vimPlugins.blink-cmp
    vimPlugins.cord-nvim
    vimPlugins.telescope-fzf-native-nvim
  ];

  extraPackages =
    [
      # external deps
      fd
      ripgrep
    ]
    ++ optionals includePerLanguageTooling [
      # lua
      stylua
      lua-language-server

      # webdev
      emmet-language-server
      vscode-langservers-extracted

      # markdown / latex
      ltex-ls-plus
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

      # etc
      nodePackages.prettier
      proselint
      taplo # toml
      yaml-language-server # yaml
      copilot-language-server
      lazygit
    ];
}
