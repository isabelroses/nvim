{
  config.perSystem =
    { lib, pkgs, ... }:
    {
      neovim = {
        package = pkgs.neovim-unwrapped;

        paths = with pkgs; [
          # external deps
          fd
          git
          gh
          ripgrep

          # python
          ruff
          pyright

          # lua
          stylua
          lua-language-server
          luaPackages.tl
          luaPackages.teal-language-server

          # webdev
          deno
          nodePackages.nodejs
          nodePackages.volar
          nodePackages."@astrojs/language-server"
          nodePackages."@tailwindcss/language-server"
          nodePackages.alex
          nodePackages.bash-language-server
          nodePackages.dockerfile-language-server-nodejs
          nodePackages.graphql
          nodePackages.graphql-language-service-cli
          nodePackages.intelephense
          nodePackages.typescript
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted

          # nix
          nil
          statix
          deadnix
          nixfmt-rfc-style

          # etc
          emmet-ls
          ltex-ls
          nodePackages.prettier
          proselint
          shellcheck
          marksman # markdown
          shfmt
          taplo # toml
          nodePackages.yaml-language-server # yaml
          nushell
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
          settings.install.colorscheme = [ "catppuccin" ];
          plugins = import ./plugins { inherit pkgs; };
        };
      };
    };
}
