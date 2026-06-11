let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);

  fetchInput =
    args:
    builtins.fetchTarball {
      url = args.url or "https://github.com/${args.owner}/${args.repo}/archive/${args.rev}.tar.gz";
      sha256 = args.narHash;
    };

  sources' = builtins.mapAttrs (_: value: fetchInput value.locked) lock.nodes;
in

{
  sources ? sources',

  pkgs ? import sources.nixpkgs {
    inherit system;
    overlays = [ ];
    config.allowUnfree = true;
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,

  gift-wrap ? import sources.gift-wrap {
    inherit pkgs lib system;
  },
}:
let
  packages = lib.makeScope pkgs.newScope (self: {
    izvim = self.callPackage ./package.nix { };
    inherit (gift-wrap) wrapNeovim;
  });
in
packages
