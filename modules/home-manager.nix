self:
{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.izvim;

  pkgs' = import ../default.nix { inherit pkgs self; };
in
{
  options = {
    programs.izvim = {
      enable = lib.mkEnableOption "izvim";

      package = lib.mkPackageOption pkgs' "izvim" { };

      includePerLanguageTooling = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to include per-language tooling in izvim.";
      };

      treesitter-grammars = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        description = ''
          List of treesitter grammars to include in izvim.
        '';
        default = null;
      };

      gui = {
        enable = lib.mkEnableOption "izvim GUI";

        package = lib.mkPackageOption pkgs "neovide" { };

        settings = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
          description = "Settings to pass to neovide";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.izvim = {
      package = pkgs'.izvim.override {
        inherit (cfg) includePerLanguageTooling treesitter-grammars;
      };

      gui.package = pkgs.symlinkJoin {
        name = "neovide-wrapped";

        paths = [ pkgs.neovide ];
        nativeBuildInputs = [ pkgs.makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/neovide \
            --add-flags '--neovim-bin' \
            --add-flags '${lib.getExe cfg.package}' \
            ${lib.optionalString (cfg.gui.settings != { }) (
              lib.concatMapAttrsStringSep " " (name: value: "--add-flags '${name}=${value}'") cfg.gui.settings
            )}
        '';
      };
    };

    home.packages = [ cfg.package ] ++ lib.optional cfg.gui.enable cfg.gui.package;
  };
}
