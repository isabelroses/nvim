{
  lib,
  stdenvNoCC,
}: let
  snippets = builtins.readDir ./src;
  packageJSON = builtins.toJSON {
    name = "my-snippets";
    engines.vscode = ">=1.0.0";
    contributes.snippets =
      builtins.mapAttrs (name: _: let
        language = builtins.head (lib.splitString ".json" name);
      in {
        inherit language;
        path = "./snippets/${name}";
      })
      snippets;
  };
in
  stdenvNoCC.mkDerivation (_: {
    pname = "my-snippets";
    version = "unstable";

    src = ./src;

    dontConfigure = true;
    dontInstall = true;

    buildPhase = ''
      mkdir -p $out/snippets
      cp -r $src/* $out/snippets
      echo '${packageJSON}' > $out/package.json
    '';
  })
