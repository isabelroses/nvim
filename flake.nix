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
      inherit (nixpkgs.lib) genAttrs;

      forAllSystems =
        function:
        genAttrs (import systems) (
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

      packages = forAllSystems (
        pkgs:
        let
          neovim = pkgs.callPackage ./pkgs/neovim.nix { };
        in
        {
          inherit neovim;
          default = neovim;
          nvim-treesitter = pkgs.callPackage ./pkgs/nvim-treesitter { };
        }
      );

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
          ] ++ nixpkgs.lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
        };

        generate-treesitter = pkgs.mkShellNoCC {
          packages = [
            pkgs.nvfetcher

            (pkgs.writeShellApplication {
              name = "generate";
              runtimeInputs = [ (pkgs.callPackage ./pkgs/nvim-treesitter/neovim.nix { }) ];

              text = ''
                nvim --headless -l ${./pkgs/nvim-treesitter/generate-nvfetcher.lua}
              '';
            })
          ];
        };
      });
    };
}
