{
  # extra utils for building the derivation
  lib,
  callPackage,
  runCommandLocal,
  symlinkJoin,
  makeWrapper,

  # neovim
  pname ? "izvim",
  basePackage ? neovim-unwrapped, # you can choose the base, i choose neovim-unwrapped
  neovim-unwrapped,
  vimUtils,

  # path, see there explanation below
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
  gonvim-tools,
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
  dockerfile-language-server-nodejs,
  lazygit,
  nodePackages,

  # for our extra plugins
  vimPlugins,

  # our custom treesitter plugin
  treesitter ? (callPackage ./nvim-treesitter { }).override {
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
  },
  ...
}:
let
  inherit (lib.lists) flatten;
  inherit (lib.strings) concatMapStringsSep makeBinPath;
  inherit (builtins)
    baseNameOf
    typeOf
    mapAttrs
    attrValues
    removeAttrs
    ;

  externalDeps = [
    # external deps
    fd
    ripgrep

    # lua
    stylua
    lua-language-server

    # webdev
    emmet-language-server
    tailwindcss-language-server
    typescript
    vscode-langservers-extracted
    nodePackages.graphql-language-service-cli

    # markdown / latex
    ltex-ls
    nodePackages.alex
    marksman

    # go
    gonvim-tools

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
    dockerfile-language-server-nodejs
    lazygit
  ];

  mkPlugin =
    pname: attrs:
    vimUtils.buildVimPlugin {
      inherit pname;
      inherit (attrs) src version;
    };

  nv = removeAttrs (callPackage ../_sources/generated.nix { }) [
    "override"
    "overrideDerivation"
  ];

  nvPlugins = mapAttrs mkPlugin nv;

  packDir = runCommandLocal "packdir" { } ''
    mkdir -pv $out/pack/${pname}/{start,opt}

    ${concatMapStringsSep "\n" (p: ''
      ln -vsfT ${p} $out/pack/${pname}/opt/${
        if typeOf p == "path" then baseNameOf p else (p.pname or p.name)
      }
    '') plugins}

    ln -vsfT ${../config} $out/pack/${pname}/start/init-plugin
  '';

  plugins = flatten [
    (attrValues nvPlugins)
    treesitter

    # extra plugsns beacuse they often fail or need extra steps
    vimPlugins.cord-nvim
    vimPlugins.telescope-fzf-native-nvim
  ];
in
symlinkJoin {
  name = pname;

  paths = [ basePackage ];
  nativeBuildInputs = [ makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/nvim \
      --prefix PATH : ${makeBinPath externalDeps} \
      --add-flags '-u' \
      --add-flags 'NORC' \
      --add-flags '--cmd' \
      --add-flags '"lua vim.loader.enable()"' \
      --add-flags '--cmd' \
      --add-flags '"set packpath^=${packDir} | set runtimepath^=${packDir}"' \
      --set 'NVIM_APPNAME=${pname}'

    ln -s $out/bin/nvim $out/bin/${pname}
  '';

  meta.mainProgram = "nvim";
}
