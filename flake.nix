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
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (pkgs: {
        neovim = pkgs.callPackage ./nix/neovim.nix { };
        default = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;

        neovimMinimal = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim.override {
          includePerLanguageTooling = false;
        };

        # expose the wrapper for public consumption
        wrapper = pkgs.callPackage ./nix/wrapper/package.nix { };

        nvim-treesitter = pkgs.callPackage ./nix/extrapkgs/nvim-treesitter { };
        nil = pkgs.callPackage ./nix/extrapkgs/nil.nix { };

        generate-treesitter = pkgs.writeShellApplication {
          name = "generate";
          runtimeInputs = [
            (pkgs.callPackage ./nix/extrapkgs/nvim-treesitter/neovim.nix { })
          ];

          text = ''
            nvim --headless -l ${./nix/extrapkgs/nvim-treesitter/generate-nvfetcher.lua}
          '';
        };

        update = pkgs.writeShellApplication {
          name = "update";
          runtimeInputs = [
            pkgs.nvfetcher
            self.packages.${pkgs.stdenv.hostPlatform.system}.generate-treesitter
          ];

          text = ''
            nvfetcher
            pushd nix/extrapkgs/nvim-treesitter
            generate
            nvfetcher
            popd
          '';
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
            self.packages.${pkgs.stdenv.hostPlatform.system}.update
            self.packages.${pkgs.stdenv.hostPlatform.system}.generate-treesitter
          ] ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
        };
      });
    };
}
