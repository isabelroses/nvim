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
          tailwindcss-language-server
          typescript
          vscode-langservers-extracted
          nodePackages.graphql-language-service-cli
          nodejs-slim

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
          yaml-language-server # yaml
          dockerfile-language-server-nodejs
        ];

        build = lib.mkForce {
          before = pkgs.writeTextFile {
            name = "before.lua";
            text = ''
              -- set space as leader
              vim.g.mapleader = " "
              vim.g.maplocalleader = " "

              -- disable remote plugin providers
              vim.g.loaded_node_provider = 0
              vim.g.loaded_perl_provider = 0
              vim.g.loaded_python_provider = 0
              vim.g.loaded_python3_provider = 0
              vim.g.loaded_ruby_provider = 0
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
