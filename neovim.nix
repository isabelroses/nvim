{
  config = {
    perSystem = {pkgs, ...}: {
      neovim = {
        package = pkgs.neovim-unwrapped;

        paths = with pkgs; [
          # external deps
          fd
          git
          ripgrep
          lazygit

          # python
          black
          isort
          nodePackages.pyright

          # lua
          stylua
          lua-language-server
          luaPackages.tl
          luaPackages.teal-language-server

          # webdev
          deno
          nodePackages.nodejs
          # nodePackages."@astrojs/language-server"
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
          nodePackages.yaml-language-server

          # nix
          alejandra
          nil
          statix
          deadnix

          # go
          # see https://github.com/ray-x/go.nvim/blob/master/lua/go/install.lua
          go
          delve # dlv
          ginkgo
          # go-enum
          gofumpt
          golangci-lint
          golines
          gomodifytags
          # gomvp
          gopls
          gotests
          gotestsum
          gotools # callgraph, goimports, gorename, guru
          govulncheck
          iferr
          impl
          # json-to-struct
          mockgen
          reftools # fillstruct, fillswitch
          richgo

          # etc
          emmet-ls
          ltex-ls
          nodePackages.prettier
          proselint
          shellcheck
          shfmt
          taplo
        ];

        lazy = {
          settings.install.colorscheme = ["catppuccin"];
          plugins = import ./plugins {inherit pkgs;};
        };
      };
    };
  };
}
