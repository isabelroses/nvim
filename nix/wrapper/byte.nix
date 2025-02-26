# modified from https://github.com/nix-community/nixvim/pull/1887
{
  lib,

  # builders
  writeText,
  makeSetupHook,
  symlinkJoin,

  # deps
  luajit,
}:
let
  byteCompileLuaHook = makeSetupHook { name = "byte-compile-lua-hook"; } (
    let
      luajit' = lib.getExe' luajit "luajit";
    in
    writeText "byte-compile-lua-hook.sh"
      # bash
      ''
        byteCompileLuaPostFixup() {
            # Target is a single file
            if [[ -f $out ]]; then
                if [[ $out = *.lua ]]; then
                    tmp=$(mktemp)
                    ${luajit'} -bd -- "$out" "$tmp"
                    mv "$tmp" "$out"
                fi
                return
            fi

            # Target is a directory
            while IFS= read -r -d "" file; do
                tmp=$(mktemp -u "$file.XXXX")
                # Ignore invalid lua files
                if ${luajit'} -bd -- "$file" "$tmp"; then
                    mv "$tmp" "$file"
                else
                    echo "WARNING: Ignoring byte compiling error for '$file' lua file" >&2
                fi
            done < <(find "$out" -type f,l -name "*.lua" -print0)
        }
        postFixupHooks+=(byteCompileLuaPostFixup)
      ''
  );

  byteCompileLuaDrv =
    drv:
    drv.overrideAttrs (
      prev:
      {
        nativeBuildInputs = prev.nativeBuildInputs or [ ] ++ [ byteCompileLuaHook ];
      }
      // lib.optionalAttrs (prev ? buildCommand) {
        buildCommand = ''
          ${prev.buildCommand}
          runHook postFixup
        '';
      }
    );

  byteCompileNeovim =
    pkg:
    symlinkJoin {
      name = "neovim-byte-compiled-${lib.getVersion pkg}";
      paths = [ pkg ];
      # Required attributes from original neovim package
      inherit (pkg) lua;
      nativeBuildInputs = [ byteCompileLuaHook ];
      postBuild = ''
        # Replace Nvim's binary symlink with a regular file,
        # or Nvim will use original runtime directory
        rm $out/bin/nvim
        cp ${pkg}/bin/nvim $out/bin/nvim
        runHook postFixup
      '';
    };
in
{
  inherit byteCompileLuaHook byteCompileLuaDrv byteCompileNeovim;
}
