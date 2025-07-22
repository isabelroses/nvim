{
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [ ];
    config.allowUnfree = true;
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,

  # wow this is hacky
  inputs,
  self ? inputs.self,
  izvimVersion ? self.shortRev or self.dirtyRev or "unknown",
}:
let
  packages = lib.makeScope pkgs.newScope (self: {
    izvim = self.callPackage ./pkgs/izvim/package.nix { inherit izvimVersion; };
    izvimPlugins = self.callPackage ./pkgs/izvim-plugins/package.nix { };
    inherit (inputs.gift-wrap.legacyPackages.${pkgs.stdenv.hostPlatform.system}) wrapNeovim;
  });
in
packages
