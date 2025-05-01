{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      forAllSystems =
        function:
        lib.genAttrs (import systems) (
          system:
          function (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [ ];
            }
          )
        );

      mkPackages =
        default: pkgs:
        let
          generatedPackages = import ./default.nix { inherit pkgs; };
          defaultPackage = lib.optionalAttrs default { default = generatedPackages.izvim; };
        in
        generatedPackages // defaultPackage;
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      legacyPackages = forAllSystems (mkPackages true);
      packages = forAllSystems (mkPackages true);

      overlays.default = _: mkPackages false;

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
          ] ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
        };
      });

      apps = forAllSystems (pkgs: {
        update = {
          type = "app";
          program = lib.getExe (
            pkgs.writeShellApplication {
              name = "update";

              runtimeInputs = [
                pkgs.nvfetcher
                pkgs.generate-treesitter
              ];

              text = ''
                pushd pkgs/izvimPlugins
                nvfetcher
                popd

                pushd pkgs/nvim-treesitter
                generate
                nvfetcher
                popd
              '';
            }
          );
        };
      });
    };
}
