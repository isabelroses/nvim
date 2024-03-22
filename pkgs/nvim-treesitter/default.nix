{
  callPackage,
  lib,
  stdenv,
  symlinkJoin,
  tree-sitter,
  pkgs,
}: let
  nvplugins = callPackage ../../_sources/generated.nix {};
  nvgrammars = callPackage ./_sources/generated.nix {};
  inherit (nvplugins) nvim-treesitter;

  ts-generate = {
    overrides.buildInputs = [pkgs.nodejs];
    overrides.preBuild = "${tree-sitter}/bin/tree-sitter generate";
  };

  grammars = {
    arduino = {};
    astro = {};
    awk = {};
    bash = {};
    beancount = {};
    c = {};
    cpp = {};
    d = ts-generate;
    css = {};
    csv = {};
    diff = {};
    dockerfile = {};
    git_config = {};
    git_rebase = {};
    gitattributes = {};
    gitcommit = {};
    gitignore = {};
    go = {};
    gomod = {};
    gosum = {};
    gotmpl = {};
    gpg = {};
    graphql = {};
    haskell = {};
    hlsl = {};
    html = {};
    javascript = {};
    just = ts-generate;
    jsdoc = {};
    json = {};
    jsonc = {};
    lua = {};
    make = {};
    markdown = {};
    markdown_inline = {};
    norg = {};
    norg_meta = {};
    nix = {};
    # php = {};
    pug = {};
    python = {};
    rust = {};
    scss = {};
    typescript = {};
    tsv = {};
    tsx = {};
    svelte = {};
    vue = {};
    yaml = {};
  };

  treesitterGrammars = lib.mapAttrsToList (name: attrs:
    stdenv.mkDerivation (let
      nvgrammar = nvgrammars."tree-sitter-grammar-${name}";
      sourceRoot =
        if lib.hasAttr "location" nvgrammar
        then nvgrammar.location
        else ".";
    in
      {
        inherit (nvgrammar) pname version src;

        buildInputs = [tree-sitter];

        CFLAGS = ["-Isrc" "-O2"];
        CXXFLAGS = ["-Isrc" "-O2"];

        dontConfigure = true;

        buildPhase = ''
          runHook preBuild
          cd ${sourceRoot}
          if [[ -e "src/scanner.cc" ]]; then
            $CXX -c "src/scanner.cc" -o scanner.o $CXXFLAGS
          elif [[ -e "src/scanner.c" ]]; then
            $CC -c "src/scanner.c" -o scanner.o $CFLAGS
          fi
          $CC -c "src/parser.c" -o parser.o $CFLAGS
          $CXX -shared -o parser *.o
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out/parser
          mv parser $out/parser/${name}.so
          runHook postInstall
        '';

        fixupPhase = lib.optionalString stdenv.isLinux ''
          runHook preFixup
          $STRIP $out/parser/${name}.so
          runHook postFixup
        '';
      }
      // attrs.overrides or {}))
  grammars;
in
  symlinkJoin {
    name = "nvim-tree-sitter";
    paths = [nvim-treesitter.src] ++ treesitterGrammars;
  }
