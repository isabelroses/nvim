{
  lib,
  callPackage,

  # builders
  runCommand,
  runCommandLocal,
  makeBinaryWrapper,
  writeText,

  # neovim
  pname ? "neovim",

  # you can choose the base, i choose neovim-unwrapped
  basePackage ? neovim-unwrapped,
  neovim-unwrapped,

  # setup lua
  lua ? basePackage.lua,
  luaEnv ? lua.withPackages extraLuaPackages,
  extraLuaPackages ? lp: [ ],

  # path, see there explanation below
  extraPackages ? [ ],

  # plugins
  plugins ? [ ],

  # our config
  userConfig,
}:
let
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatMapStringsSep makeBinPath escapeShellArgs;
  inherit (builtins) typeOf;

  bytes = callPackage ./byte.nix { };

  compiledPlugins = map bytes.byteCompileLuaDrv plugins;

  compiledConfig = bytes.byteCompileLuaDrv (
    runCommandLocal "nvim-config" { passthru.start = true; } ''
      mkdir $out
      cp -r ${userConfig}/* $out
    ''
  );

  finalPlugins = compiledPlugins ++ [ compiledConfig ];

  packDir = runCommandLocal "packdir" { } ''
    mkdir -pv $out/pack/${pname}/{start,opt}

     ${concatMapStringsSep "\n" (p: ''
       ln -vsfT ${p} $out/pack/${pname}/${if (p.passthru.start or false) then "start" else "opt"}/${
         if typeOf p == "path" then baseNameOf p else (p.pname or p.name)
       }
     '') finalPlugins}
  '';

  rc = writeText "rc.vim" ''
    lua package.path = "${lua.pkgs.luaLib.genLuaPathAbsStr luaEnv}"; package.cpath = "${lua.pkgs.luaLib.genLuaCPathAbsStr luaEnv}"
    set packpath^=${packDir} | set runtimepath^=${packDir}

    lua vim.loader.enable()
    lua vim.g.loaded_node_provider = 0
    lua vim.g.loaded_perl_provider = 0
    lua vim.g.loaded_python_provider = 0
    lua vim.g.loaded_python3_provider = 0
    lua vim.g.loaded_ruby_provider = 0
  '';
in
runCommand pname
  {
    __structuredAttrs = true;

    nativeBuildInputs = [ makeBinaryWrapper ];

    wrapperArgs = [
      "--suffix"
      "PATH"
      ":"
      (makeBinPath extraPackages)

      "--add-flags"
      (escapeShellArgs [
        "-u"
        (toString rc)
      ])

      "--set"
      "NVIM_APPNAME"
      pname
    ];

    meta = {
      inherit (basePackage.meta) description mainProgram;
    };
  }
  ''
    makeWrapper ${getExe basePackage} $out/bin/nvim "''${wrapperArgs[@]}"

    ln -s $out/bin/nvim $out/bin/${pname}
  ''
