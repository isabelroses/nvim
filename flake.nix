{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    gift-wrap = {
      url = "github:tgirlcloud/gift-wrap";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      forAllSystems =
        f:
        lib.genAttrs lib.systems.flakeExposed (
          system:
          f (
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
          generatedPackages = import ./default.nix { inherit pkgs inputs; };
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

            excludes = [
              "pkgs/izvim-plugins/_sources/*"
            ];

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

      homeModules.default = import ./modules/home-manager.nix inputs;

      overlays.default = _: mkPackages false;

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
            pkgs.lua-language-server
            pkgs.taplo
          ]
          ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
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
