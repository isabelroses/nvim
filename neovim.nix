{
  config.perSystem = {pkgs, ...}: {
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
        nodePackages.pyright

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
        alejandra
        nil
        statix
        deadnix

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

      lazy = {
        settings.install.colorscheme = ["catppuccin"];
        plugins = import ./plugins {inherit pkgs;};
      };
    };
  };
}
