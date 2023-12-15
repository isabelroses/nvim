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

          # etc
          deno
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
