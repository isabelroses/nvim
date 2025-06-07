{
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [ ];
    config.allowUnfree = true;
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,

  # wow this is hacky
  self ? { },
  izvimVersion ? self.shortRev or self.dirtyRev or "unknown",
}:
let
  packages = lib.packagesFromDirectoryRecursive {
    directory = ./pkgs;
    callPackage = lib.callPackageWith (pkgs // packages // { inherit izvimVersion; });
  };
in
packages
