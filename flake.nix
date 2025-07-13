{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
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
          generatedPackages = import ./default.nix { inherit pkgs self; };
          defaultPackage = lib.optionalAttrs default { default = generatedPackages.izvim; };
        in
        generatedPackages // defaultPackage;
    in
    {
      formatter = forAllSystems (
        pkgs:
        pkgs.treefmt.withConfig {
          runtimeInputs = with pkgs; [
            # keep-sorted start
            deadnix
            keep-sorted
            nixfmt-rfc-style
            statix
            stylua
            taplo
            # keep-sorted end

            (writeShellScriptBin "statix-fix" ''
              for file in "$@"; do
                ${lib.getExe statix} fix "$file"
              done
            '')
          ];

          settings = {
            on-unmatched = "info";
            tree-root-file = "flake.nix";

            formatter = {
              # keep-sorted start block=yes newline_separated=yes
              deadnix = {
                command = "deadnix";
                includes = [ "*.nix" ];
              };

              keep-sorted = {
                command = "keep-sorted";
                includes = [ "*" ];
              };

              nixfmt = {
                command = "nixfmt";
                includes = [ "*.nix" ];
              };

              statix = {
                command = "statix-fix";
                includes = [ "*.nix" ];
              };

              stylua = {
                command = "stylua";
                includes = [ "*.lua" ];
              };

              taplo = {
                command = "taplo";
                options = "format";
                includes = [ "*.toml" ];
              };
              # keep-sorted end
            };
          };
        }
      );

      legacyPackages = forAllSystems (mkPackages true);
      packages = forAllSystems (mkPackages true);

      homeModules.default = import ./modules/home-manager.nix self;

      overlays.default = _: mkPackages false;

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
            pkgs.lua-language-server
            pkgs.taplo
          ] ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
        };
      });

      apps = forAllSystems (pkgs: {
        update = {
          type = "app";
          program = lib.getExe (
            pkgs.writeShellApplication {
              name = "update";
              runtimeInputs = [ pkgs.nvfetcher ];

              text = ''
                pushd pkgs/izvim-plugins
                nvfetcher
                popd
              '';
            }
          );
        };
      });
    };
}
