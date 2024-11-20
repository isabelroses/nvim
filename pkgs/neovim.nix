{
  # extra utils for building the derivation
  lib,
  callPackage,
  runCommandLocal,
  runCommand,
  makeBinaryWrapper,
  writeText,

  # neovim
  pname ? "izvim",
  basePackage ? neovim-unwrapped, # you can choose the base, i choose neovim-unwrapped
  neovim-unwrapped,
  vimUtils,

  lua ? basePackage.lua,
  luaEnv ? lua.withPackages extraLuaPackages,
  extraLuaPackages ? lp: [ ],

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

  # for our extra plugins
  vimPlugins,

  # our custom treesitter plugin
  treesitter ? (callPackage ./nvim-treesitter { }).override {
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
  ...
}:
let
  inherit (lib.lists) flatten;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatMapStringsSep makeBinPath escapeShellArgs;
  inherit (builtins)
    baseNameOf
    typeOf
    mapAttrs
    readFile
    fromTOML
    fromJSON
    attrValues
    removeAttrs
    ;

  externalDeps = [
    # external deps
    fd
    ripgrep

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
    nodePackages.graphql-language-service-cli

    # markdown / latex
    ltex-ls
    nodePackages.alex
    marksman

    # go
    gonvim-tools

    # nix
    (callPackage ./nil.nix { })
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

  nv = removeAttrs (callPackage ../_sources/generated.nix { }) [
    "override"
    "overrideDerivation"
  ];

  toml = fromTOML (readFile ../nvfetcher.toml);

  nvPlugins = mapAttrs mkPlugin nv;

  mkPlugin =
    name: attrs:
    let
      old = toml.${name};
    in
    vimUtils.buildVimPlugin {
      pname = old.passthru.as or (baseNameOf old.src.git);
      inherit (attrs) src version;
      passthru.start = if (attrs ? start) then fromJSON attrs.start else false;
    };

  packDir = runCommandLocal "packdir" { } ''
    mkdir -pv $out/pack/${pname}/{start,opt}

    ${concatMapStringsSep "\n" (p: ''
      ln -vsfT ${p} $out/pack/${pname}/${if (p.passthru.start or false) then "start" else "opt"}/${
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

  rc = writeText "rc.vim" ''
    lua package.path = "${lua.pkgs.luaLib.genLuaPathAbsStr luaEnv}"; package.cpath = "${lua.pkgs.luaLib.genLuaCPathAbsStr luaEnv}"
    set packpath^=${packDir} | set runtimepath^=${packDir}

    lua vim.loader.enable()
    lua vim.g.loaded_node_provider = 0
    lua vim.g.loaded_perl_provider = 0
    lua vim.g.loaded_python_provider = 0
    lua vim.g.loaded_python3_provider = 0
    lua vim.g.loaded_ruby_provider = 0
  '';
in
runCommand pname
  {
    __structuredAttrs = true;

    nativeBuildInputs = [ makeBinaryWrapper ];

    wrapperArgs = [
      "--suffix"
      "PATH"
      ":"
      (makeBinPath externalDeps)

      "--add-flags"
      (escapeShellArgs [
        "-u"
        (toString rc)
      ])

      "--set"
      "NVIM_APPNAME"
      pname
    ];

    meta = {
      inherit (basePackage.meta) description mainProgram;
    };
  }
  ''
    makeWrapper ${getExe basePackage} $out/bin/nvim "''${wrapperArgs[@]}"

    ln -s $out/bin/nvim $out/bin/${pname}
  ''
