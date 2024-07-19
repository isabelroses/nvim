{
  config.perSystem =
    {
      lib,
      pkgs,
      # inputs',
      ...
    }:
    {
      neovim = {
        # package = inputs'.neovim-nightly-overlay.packages.default;
        package = pkgs.neovim-unwrapped;

        paths = with pkgs; [
          # external deps
          fd
          ripgrep

          # lua
          stylua
          lua-language-server

          # webdev
          emmet-language-server
          nodePackages."@astrojs/language-server"
          nodePackages."@tailwindcss/language-server"
          nodePackages.typescript
          nodePackages.vscode-langservers-extracted
          nodePackages.graphql-language-service-cli

          # markdown / latex
          ltex-ls
          nodePackages.alex
          marksman

          # nix
          nil
          statix
          deadnix
          nixfmt-rfc-style

          # shell
          shfmt
          shellcheck
          bash-language-server

          # etc
          nodePackages.prettier
          proselint
          taplo # toml
          nodePackages.yaml-language-server # yaml
          nodePackages.dockerfile-language-server-nodejs # docker
        ];

        build =
          let
            env = pkgs.buildEnv {
              name = "neovim-host-prog";
              paths = [ pkgs.nodePackages.neovim ] ++ [ (pkgs.python3.withPackages (ps: with ps; [ pynvim ])) ];
            };
          in
          lib.mkForce {
            before = pkgs.writeTextFile {
              name = "before.lua";
              text = ''
                -- set space as leader
                vim.g.mapleader = " "
                vim.g.maplocalleader = " "

                -- this defaults to this and we want to keep it that way
                vim.g.node_host_prog = "${env}/bin/neovim-node-host"
                vim.g.python3_host_prog = "${env}/bin/python"
              '';
            };
          };

        lazy = {
          settings.dev.path = "~/dev/nvim";
          plugins = import ./plugins { inherit pkgs; };
        };
      };
    };
}
