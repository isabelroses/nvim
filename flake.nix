{
  description = "isabelroses' neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    neovim-nix = {
      url = "github:willruggiano/neovim.nix";
      inputs = {
        flake-parts.follows = "flake-parts";
        neovim.follows = "";
        nixpkgs.follows = "nixpkgs";
        pre-commit-nix.follows = "pre-commit-nix";
      };
    };

    # maintenance
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      imports = [
        inputs.neovim-nix.flakeModule
        ./neovim.nix
      ];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [];
        };

        checks = {
          pre-commit-check = inputs.pre-commit-nix.lib.${system}.run {
            src = ./.;
            excludes = ["_sources/.+"];
            hooks = {
              alejandra.enable = true;
              stylua.enable = true;
            };
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (inputs.self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = with pkgs; [nil statix deadnix nix-tree];
        };

        formatter = pkgs.alejandra;

        packages = rec {
          default = neovim;
          neovim = config.neovim.final;
          nvim-treesitter = pkgs.callPackage ./pkgs/nvim-treesitter {};
          telescope-fzf-native = pkgs.callPackage ./pkgs/telescope-fzf-native {};
          markdown-preview = pkgs.callPackage ./pkgs/markdown-preview {};
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
