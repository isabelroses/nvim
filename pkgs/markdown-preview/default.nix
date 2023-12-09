{
  callPackage,
  fixup_yarn_lock,
  lib,
  nodejs,
  runCommand,
  vimUtils,
  writeText,
  yarn,
  yarn2nix,
}: let
  nvfetcher = (callPackage ../../_sources/generated.nix {}).markdown-preview;

  yarnLock = writeText "yarn.lock" nvfetcher."app/yarn.lock";
  yarnDrv = runCommand "yarn2nix" {} ''
    ${yarn2nix}/bin/yarn2nix --lockfile="${yarnLock}" --no-patch --builtin-fetchgit > "$out"
  '';

  offlineCache = (callPackage yarnDrv {}).offline_cache;

  defaultYarnFlags = [
    "--offline"
    "--frozen-lockfile"
    "--ignore-engines"
    "--ignore-scripts"
  ];
in
  vimUtils.buildVimPlugin {
    inherit (nvfetcher) pname version src;
    buildInputs = [nodejs yarn];
    buildPhase = ''
      runHook preBuild

      export HOME=$(pwd)
      yarn config set yarn-offline-mirror ${offlineCache}
      cd app
      ${fixup_yarn_lock}/bin/fixup_yarn_lock ./yarn.lock
      yarn install ${lib.escapeShellArgs defaultYarnFlags}
      cd ..

      runHook postBuild
    '';
  }
