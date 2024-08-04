{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        rust-overlay.follows = "beapkgs/rust-overlay";
      };
    };

    beapkgs = {
      url = "github:isabelroses/beapkgs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-parts.follows = "flake-parts";
    #     git-hooks.follows = "pre-commit-nix";
    #     flake-compat.follows = "";
    #   };
    # };

    systems.url = "github:nix-systems/default";

    # maintenance
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    inputs:
    let
      systems = import inputs.systems;

      inherit (inputs.nixpkgs) lib;

      forAllSystem =
        function:
        lib.genAttrs systems (
          system:
          function (
            import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [
                inputs.nil.overlays.nil
                inputs.beapkgs.overlays.default
              ];
            }
          )
        );
    in
    {
      formatter = forAllSystem (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystem (pkgs: rec {
        default = neovim;
        neovim = pkgs.callPackage ./neovim.nix {
          version = inputs.self.shortRev or inputs.self.dirtyShortRev or "dirty";
        };
        nvim-treesitter = pkgs.callPackage ./pkgs/nvim-treesitter { };
      });

      devShells = forAllSystem (pkgs: {
        default = pkgs.mkShellNoCC { packages = with pkgs; [ nvfetcher ]; };

        generate-treesitter = pkgs.mkShellNoCC {
          packages = with pkgs; [
            nvfetcher
            (writeShellApplication {
              name = "generate";
              runtimeInputs = [ (callPackage ./pkgs/nvim-treesitter/neovim.nix { }) ];

              text = ''
                nvim --headless -l ${./pkgs/nvim-treesitter/generate-nvfetcher.lua}
              '';
            })
          ];
        };
      });
    };
}
