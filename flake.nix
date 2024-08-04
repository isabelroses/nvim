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
    #     git-hooks.follows = "git-hooks";
    #     flake-compat.follows = "";
    #   };
    # };

    chainix = {
      url = "github:catgardens/chainix";
      # url = "git+file:///Users/isabel/dev/chainix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
      };
    };

    systems.url = "github:nix-systems/default";

    # maintenance
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        inputs.chainix.flakeModule
        ./neovim.nix
      ] ++ inputs.nixpkgs.lib.optional (inputs.git-hooks ? flakeModule) inputs.git-hooks.flakeModule;

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
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              inputs.nil.overlays.nil
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

          devShells = {
            default = pkgs.mkShellNoCC {
              inherit (self'.checks.pre-commit-check) shellHook;
              buildInputs = with pkgs; [
                self'.formatter
                nvfetcher
              ];
            };

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
        };
    };
}
