{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
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
      url = "github:isabelroses/neovim.nix/dev";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
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
    { nixpkgs, flake-parts, ... }@inputs:
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
      ] ++ nixpkgs.lib.optional (inputs.git-hooks ? flakeModule) inputs.git-hooks.flakeModule;

      perSystem =
        {
          lib,
          pkgs,
          self',
          config,
          system,
          ...
        }:
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              inputs.nil.overlays.default
              inputs.beapkgs.overlays.default
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
            };

          devShells.generate-treesitter = pkgs.mkShellNoCC {
            packages = with pkgs; [
              nvfetcher
              (callPackage ./pkgs/nvim-treesitter/neovim.nix { })
            ];
          };
        }
        // lib.optionalAttrs (inputs.git-hooks ? flakeModule) {
          checks.pre-commit-check = inputs.git-hooks.lib.${system}.run {
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

          devShells.default = pkgs.mkShellNoCC {
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
        };
    };
}
