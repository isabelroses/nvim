{
  lib,
  callPackage,

  # get extra plugins we don't want to build
  vimPlugins,

  # we need to build some plugins
  vimUtils,

  # path
  fd,
  ripgrep,
  stylua,
  lua-language-server,
  emmet-language-server,
  tailwindcss-language-server,
  typescript,
  vscode-langservers-extracted,
  ltex-ls,
  marksman,
  # nil,
  statix,
  deadnix,
  nixfmt-rfc-style,
  shfmt,
  shellcheck,
  bash-language-server,
  proselint,
  taplo,
  yaml-language-server,
  dockerfile-language-server-nodejs,
  lazygit,
  nodePackages,
  nodejs-slim,

  treesitter ? (callPackage ./extrapkgs/nvim-treesitter { }).override {
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

  # settings
  includePerLanguageTooling ? true,
}:
let
  inherit (lib.lists) flatten optionals;
  inherit (lib.trivial) importTOML;
  inherit (builtins)
    baseNameOf
    mapAttrs
    fromJSON
    removeAttrs
    attrValues
    replaceStrings
    ;

  wrapNeovim = callPackage ./wrapper/package.nix;

  nv = removeAttrs (callPackage ../_sources/generated.nix { }) [
    "override"
    "overrideDerivation"
  ];

  toml = importTOML ../nvfetcher.toml;

  nvPlugins = mapAttrs mkPlugin nv;

  mkPlugin =
    name: attrs:
    let
      old = toml.${name};
    in
    vimUtils.buildVimPlugin {
      pname = old.passthru.as or (baseNameOf old.src.git);
      version = replaceStrings [ "-" ] [ "." ] attrs.date;

      inherit (attrs) src;

      doCheck = false;

      passthru.start = if (attrs ? start) then fromJSON attrs.start else false;
    };
in
wrapNeovim {
  pname = "izvim";

  userConfig = ../config;

  plugins = flatten [
    (attrValues nvPlugins)
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
      # needed for copilot
      nodejs-slim

      # lua
      stylua
      lua-language-server

      # webdev
      emmet-language-server
      tailwindcss-language-server
      typescript
      vscode-langservers-extracted

      # markdown / latex
      ltex-ls
      marksman

      # nix
      (callPackage ./extrapkgs/nil.nix { })
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
      dockerfile-language-server-nodejs
      lazygit
    ];
}
