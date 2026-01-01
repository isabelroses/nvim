inputs:
{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.izvim;

  pkgs' = import ../default.nix { inherit pkgs inputs; };
in
{
  options = {
    programs.izvim = {
      enable = lib.mkEnableOption "izvim";

      package = lib.mkPackageOption pkgs' "izvim" { };

      bundleLSPs = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to bundle LSPs in izvim.";
      };

      packageOverrides = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.anything;
        default = { };
        description = "Arguments to add to the package override";
        example = lib.literalExpression ''
          {
            nil = pkgs.nil.override { nix = pkgs.lix; };
          }
        '';
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
      package = pkgs'.izvim.override (
        {
          inherit (cfg) bundleLSPs;
        }
        // cfg.packageOverrides
      );

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
