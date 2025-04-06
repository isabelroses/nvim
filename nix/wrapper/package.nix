{
  lib,

  # builders
  runCommand,
  stdenvNoCC,
  makeBinaryWrapper,
  writeText,
  envsubst,
  lndir,

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
  inherit (lib.meta) getExe defaultPriority;
  inherit (lib.strings) concatMapStringsSep makeBinPath getVersion;
  inherit (builtins) typeOf baseNameOf;

  inherit (lua.pkgs) luaLib;

  init = writeText "init.lua" ''
    package.path = "${luaLib.genLuaPathAbsStr luaEnv};$LUA_PATH" .. package.path
    package.cpath = "${luaLib.genLuaCPathAbsStr luaEnv};$LUA_CPATH" .. package.cpath
    vim.env.PATH =  vim.env.PATH .. ":${makeBinPath extraPackages}"
    vim.opt.packpath:append('$out')
    vim.opt.runtimepath:append('$out')

    vim.loader.enable()
    vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_python_provider = 0
    vim.g.loaded_python3_provider = 0
    vim.g.loaded_ruby_provider = 0
  '';

  finalConfig = runCommand "neovim-config" { } ''
    mkdir -pv $out/pack/${pname}/{start,opt}

    ${concatMapStringsSep "\n" (p: ''
      ln -vsfT ${p} $out/pack/${pname}/${if (p.passthru.start or false) then "start" else "opt"}/${
        if typeOf p == "path" then baseNameOf p else (p.pname or p.name)
      }
    '') plugins}

    ln -vsfT ${userConfig} $out/pack/${pname}/start/init-plugin

    ${getExe envsubst} < '${init}' > "$out/init.lua"

    mkdir $out/nix-support
    for i in $(find -L $out -name propagated-build-inputs ); do
      cat "$i" >> $out/nix-support/propagated-build-inputs
    done
  '';
in
stdenvNoCC.mkDerivation {
  inherit pname;
  version = getVersion basePackage;

  __structuredAttrs = true;

  nativeBuildInputs = [
    makeBinaryWrapper
    lndir
  ];

  dontUnpack = true;
  strictDeps = true;
  dontRewriteSymlinks = true;

  wrapperArgs = [
    "--add-flags"
    "-u ${finalConfig}/init.lua"

    "--set-default"
    "NVIM_APPNAME"
    pname
  ];

  buildPhase = ''
    runHook preBuild

    mkdir -p $out
    lndir -silent ${basePackage} $out
    rm -rf $out/share/applications

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    wrapProgram $out/bin/nvim "''${wrapperArgs[@]}"
    ln -s $out/bin/nvim $out/bin/${pname}

    runHook postInstall
  '';

  passthru.config = finalConfig;

  meta = basePackage.meta // {
    priority = (basePackage.meta.priority or defaultPriority) - 1;
  };
}
