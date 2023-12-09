{
  callPackage,
  vimUtils,
}: let
  nvfetcher = (callPackage ../../_sources/generated.nix {}).telescope-fzf-native;
in
  vimUtils.buildVimPlugin {
    inherit (nvfetcher) pname version src;

    buildPhase = "make";
  }
