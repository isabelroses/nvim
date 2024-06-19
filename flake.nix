{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    pre-commit-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };

    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
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

    neovim-nix = {
      url = "github:nekowinston/neovim.nix/dev";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        lazy-nvim.follows = "";
        flake-parts.follows = "flake-parts";
        pre-commit-nix.follows = "pre-commit-nix";
      };
    };

    beapkgs = {
      url = "github:isabelroses/beapkgs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };

    # maintenance
    flake-utils.url = "github:numtide/flake-utils";
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
            overlays = [
              inputs.nil.overlays.default
              inputs.beapkgs.overlays.default
            ];
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

          devShells = {
            default = pkgs.mkShellNoCC {
              inherit (self'.checks.pre-commit-check) shellHook;
              buildInputs = with pkgs; [
                self'.formatter
                nil
                statix
                deadnix
                nvfetcher
                nix-tree
              ];
            };

            generate-treesitter = pkgs.mkShellNoCC {
              packages = with pkgs; [
                nvfetcher
                (callPackage ./pkgs/nvim-treesitter/neovim.nix { })
              ];
            };
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
            };
        };
    };

  nixConfig = {
    extra-substituters = [
      "https://pre-commit-hooks.cachix.org"
      "https://isabelroses.cachix.org"
    ];
    extra-trusted-public-keys = [
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
      "isabelroses.cachix.org-1:mXdV/CMcPDaiTmkQ7/4+MzChpOe6Cb97njKmBQQmLPM="
    ];
  };
}
