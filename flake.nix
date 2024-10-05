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

    neovim-nix = {
      url = "github:nekowinston/neovim.nix/feat/more-plugin-spec-fields";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        example.follows = "";
      };
    };

    systems.url = "github:nix-systems/default";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [ inputs.neovim-nix.flakeModule ./neovim.nix ]
        ++ inputs.nixpkgs.lib.optional (inputs.git-hooks ? flakeModule)
        inputs.git-hooks.flakeModule;

      perSystem = { lib, pkgs, self', config, system, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ inputs.beapkgs.overlays.default ];
          };

          formatter = pkgs.nixfmt-rfc-style;

          packages = let neovim = config.neovim.final;
          in {
            inherit neovim;
            default = neovim;
            nvim-treesitter = pkgs.callPackage ./pkgs/nvim-treesitter { };
          };

          devShells = {
            default = pkgs.mkShellNoCC {
              inherit (self'.checks.pre-commit-check) shellHook;
              buildInputs = with pkgs; [ self'.formatter nvfetcher ];
            };

            generate-treesitter = pkgs.mkShellNoCC {
              packages = with pkgs; [
                nvfetcher
                (writeShellApplication {
                  name = "generate";
                  runtimeInputs =
                    [ (callPackage ./pkgs/nvim-treesitter/neovim.nix { }) ];

                  text = ''
                    nvim --headless -l ${
                      ./pkgs/nvim-treesitter/generate-nvfetcher.lua
                    }
                  '';
                })
              ];
            };
          };
        } // lib.optionalAttrs (inputs.git-hooks ? flakeModule) {
          checks.pre-commit-check = inputs.git-hooks.lib.${system}.run {
            src = ./.;
            excludes = [ "_sources/.+" ];
            hooks = {
              nixfmt-rfc-style.enable = true;
              stylua.enable = true;
            };
          };
        };
    };
}
