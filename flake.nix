{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    beapkgs = {
      url = "github:isabelroses/beapkgs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };

    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      beapkgs,
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
              overlays = [ beapkgs.overlays.default ];
            }
          )
        );
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (pkgs: {
        neovim = pkgs.callPackage ./pkgs/neovim.nix { };
        default = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
        nvim-treesitter = pkgs.callPackage ./pkgs/nvim-treesitter { };
        nil = pkgs.callPackage ./pkgs/nil.nix { };

        generate-treesitter = pkgs.writeShellApplication {
          name = "generate";
          runtimeInputs = [
            pkgs.nvfetcher
            (pkgs.callPackage ./pkgs/nvim-treesitter/neovim.nix { })
          ];

          text = ''
            nvim --headless -l ${./pkgs/nvim-treesitter/generate-nvfetcher.lua}
          '';
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
          ] ++ nixpkgs.lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
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
                self.packages.${pkgs.stdenv.hostPlatform.system}.generate-treesitter
              ];

              text = ''
                nvfetcher
                pushd pkgs/nvim-treesitter
                generate
                nvfetcher
                popd
              '';
            }
          );
        };

        generate-treesitter = {
          type = "app";
          program = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.generate-treesitter;
        };
      });
    };
}
