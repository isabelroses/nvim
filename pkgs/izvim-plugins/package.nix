{
  lib,
  newScope,
  vimUtils,
  fetchpatch,
  callPackage,
}:
let
  inherit (lib) makeScope;
  inherit (lib.trivial) importTOML;
  inherit (builtins)
    baseNameOf
    mapAttrs
    fromJSON
    removeAttrs
    replaceStrings
    ;

  toml = importTOML ./nvfetcher.toml;
  sources = removeAttrs (callPackage ./_sources/generated.nix { }) [
    "override"
    "overrideDerivation"
  ];

  mkPlugin =
    name: args:
    let
      old = toml.${name};

      args' = removeAttrs args [
        "pname"
        "date"
        "version"
        "passthru"
      ];
    in
    vimUtils.buildVimPlugin (
      args'
      // {
        pname = old.passthru.as or (baseNameOf old.src.git);
        version = replaceStrings [ "-" ] [ "." ] args.date;

        doCheck = false;

        passthru = args.passthru or { } // {
          start = if (args ? start) then fromJSON args.start else false;
        };
      }
    );

  generatedPlugins = mapAttrs mkPlugin sources;

  madePlugins = {
    catppuccin = mkPlugin "catppuccin" (
      sources.catppuccin
      // {
        patches = [
          (fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/catppuccin/nvim/pull/804.patch";
            hash = "sha256-xhRz0mD2gkVuF9O4ndpZC0U6jzVbf0jAHGcxDuJM2T4=";
          })
        ];
      }
    );

    copilot-lua = mkPlugin "copilot-lua" (
      sources.copilot-lua
      // {
        # remove the copilot binary and deps, we will bring our own
        prePatch = ''
          rm -rf copilot
        '';
      }
    );

    nvim-treesitter = mkPlugin "nvim-treesitter" (
      sources.nvim-treesitter
      // {
        postPatch = ''
          shopt -s extglob
          rm -rf -- !(runtime)
          shopt -u extglob
          mv runtime/queries queries
          rm -rf runtime
        '';
      }
    );
  };

  plugins = generatedPlugins // madePlugins;
in
makeScope newScope (_: plugins)
