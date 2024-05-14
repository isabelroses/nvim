{ lib, stdenvNoCC }:
let
  snips = lib.filesystem.listFilesRecursive ./src;
  packageJSON = builtins.toJSON {
    name = "my-snippets";
    engines.vscode = ">=1.0.0";

    contributes.snippets = builtins.map (
      name:
      let
        base = builtins.baseNameOf name;
      in
      {
        language = lib.removeSuffix ".json" base;
        path = "./src/${base}";
      }
    ) snips;
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
