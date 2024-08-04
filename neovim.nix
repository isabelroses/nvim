{
  lib,
  pkgs,
  version,
  ...
}:
let
  isabels-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "isabels-nvim";
    inherit version;
    src = ./src;
  };

  plugins =
    [
      isabels-nvim

      ((pkgs.callPackage ./pkgs/nvim-treesitter { }).override {
        grammars = [
          "astro"
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
          "svelte"
          "toml"
          "tsv"
          "tsx"
          "typescript"
          "vim"
          "vue"
          "yaml"
          "yuck"
          "zig"
        ];
      })
    ]
    ++ builtins.removeAttrs
      (builtins.mapAttrs (_: val: { inherit (val) src; }) (pkgs.callPackage ./_sources/generated.nix { }))
      [
        "override"
        "overrideDerivation"
      ];

  extraPackages = with pkgs; [
    # external deps
    fd
    ripgrep

    # lua
    stylua
    lua-language-server

    # webdev
    emmet-language-server
    nodePackages."@astrojs/language-server"
    nodePackages."@tailwindcss/language-server"
    nodePackages.typescript
    nodePackages.vscode-langservers-extracted
    nodePackages.graphql-language-service-cli
    nodejs-slim

    # markdown / latex
    ltex-ls
    nodePackages.alex
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
    nodePackages.yaml-language-server # yaml
    nodePackages.dockerfile-language-server-nodejs # docker
  ];

  baseConfig = pkgs.neovimUtils.makeNeovimConfig {
    withRuby = false;
    inherit plugins;
  };

  config = baseConfig // {
    luaRcContent = "require('getchoo')";
    wrapperArgs = baseConfig.wrapperArgs ++ [
      "--suffix"
      "PATH"
      ":"
      "${lib.makeBinPath extraPackages}"
    ];
  };
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped config
