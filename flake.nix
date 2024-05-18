{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };

    neovim-nix = {
      url = "github:nekowinston/neovim.nix/dev";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        pre-commit-nix.follows = "pre-commit-nix";
      };
    };

    nekowinston-nur = {
      url = "github:nekowinston/nur";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        fenix.follows = "";
      };
    };

    # maintenance
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      imports = [
        inputs.neovim-nix.flakeModule
        ./neovim.nix
      ];

      perSystem =
        {
          config,
          pkgs,
          self',
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ (_: p: { nekowinston = import inputs.nekowinston-nur { inherit (p) pkgs; }; }) ];
          };

          checks = {
            pre-commit-check = inputs.pre-commit-nix.lib.${system}.run {
              src = ./.;
              excludes = [ "_sources/.+" ];
              hooks = {
                nixfmt = {
                  enable = true;
                  package = pkgs.nixfmt-rfc-style;
                };
                stylua.enable = true;
              };
            };
          };

          devShells.default = pkgs.mkShell {
            inherit (self'.checks.pre-commit-check) shellHook;
            buildInputs = with pkgs; [
              self'.formatter
              nvfetcher
              nix-tree
            ];
          };

          formatter = pkgs.nixfmt-rfc-style;

          packages =
            let
              neovim = config.neovim.final;
            in
            {
              inherit neovim;
              default = neovim;
              nvim-treesitter = pkgs.callPackage ./pkgs/nvim-treesitter { };
              my-snippets = pkgs.callPackage ./pkgs/snippets { };
            };
        };
    };

  nixConfig = {
    extra-substituters = [
      "https://pre-commit-hooks.cachix.org"
      "https://nekowinston.cachix.org"
      "https://isabelroses.cachix.org"
    ];
    extra-trusted-public-keys = [
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
      "nekowinston.cachix.org-1:lucpmaO+JwtoZj16HCO1p1fOv68s/RL1gumpVzRHRDs="
      "isabelroses.cachix.org-1:mXdV/CMcPDaiTmkQ7/4+MzChpOe6Cb97njKmBQQmLPM="
    ];
  };
}
