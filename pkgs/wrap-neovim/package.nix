{
  lib,
  runCommand,
  stdenvNoCC,
  makeBinaryWrapper,
  writeText,
  envsubst,
  xorg,
  neovim-unwrapped,
}:
lib.extendMkDerivation {
  constructDrv = stdenvNoCC.mkDerivation;

  extendDrvArgs =
    _:
    {
      # neovim
      pname ? "neovim",
      versionSuffix ? "unstable",

      # you can choose the base, i choose neovim-unwrapped
      basePackage ? neovim-unwrapped,

      # setup lua
      lua ? basePackage.lua,
      luaEnv ? lua.withPackages extraLuaPackages,
      extraLuaPackages ? _: [ ],

      # path, see there explanation below
      extraPackages ? [ ],

      # plugins
      plugins ? [ ],

      # our config
      userConfig,
    }@args:
    let
      inherit (lib.meta) getExe defaultPriority;
      inherit (lib.strings)
        concatMapStringsSep
        makeBinPath
        getVersion
        removeSuffix
        ;
      inherit (builtins) typeOf baseNameOf;

      inherit (lua.pkgs) luaLib;

      init = writeText "init.lua" ''
        package.path = "${luaLib.genLuaPathAbsStr luaEnv};$LUA_PATH" .. package.path
        package.cpath = "${luaLib.genLuaCPathAbsStr luaEnv};$LUA_CPATH" .. package.cpath
        vim.env.PATH = vim.env.PATH .. ":${makeBinPath extraPackages}"
        vim.g.snippets_path = "$out/pack/${pname}/start/init-plugin/snippets"
        vim.opt.packpath:append('$out')
        vim.opt.runtimepath:append('$out')

        vim.loader.enable()
        vim.g.loaded_node_provider = 0
        vim.g.loaded_perl_provider = 0
        vim.g.loaded_python_provider = 0
        vim.g.loaded_python3_provider = 0
        vim.g.loaded_ruby_provider = 0
      '';

      config = runCommand "neovim-config" { } ''
        mkdir -pv $out/parser
        mkdir -pv $out/pack/${pname}/{start,opt}

        echo "generating init.lua"
        ${getExe envsubst} < '${init}' > "$out/init.lua"

        echo "generating helptags"
        ${getExe basePackage} \
            -n -u NONE -i NONE \
            --headless \
            -c "set packpath=$out" \
            -c "packloadall" \
            -c "helptags ALL" \
            "+quit!"

        echo "linking plugins"
        shopt -s extglob
        ${concatMapStringsSep "\n" (p: ''
          source=${p}
          path="pack/${pname}/${if (p.passthru.start or false) then "start" else "opt"}/${
            if typeOf p == "path" then baseNameOf p else (p.pname or p.name)
          }"

          mkdir -p "$out/$path"

          tolink=("$source/"!(doc|parser))
          if (( ''${#tolink} )); then
            ln -ns "''${tolink[@]}" -t "$out/$path"
          fi

          if [[ -e "$source/parser" && -n "$(ls -A "$source/parser")" ]]; then
            ln -nsf "$source/parser" "$out/parser/${removeSuffix "-grammar" p.pname}.so"
          fi

          if [[ -e "$source/doc" && ! -e "$out/$path/doc" ]]; then
            ln -ns "$source/doc" -t "$out/$path"
          fi

          if [[ -d "$path" && -z "$(ls -A $path)" ]]; then
            rmdir $path
          fi
        '') plugins}
        shopt -u extglob

        echo "linkng user config"
        ln -vsfT ${userConfig} $out/pack/${pname}/start/init-plugin

        mkdir "$out/nix-support"
        for i in $(find -L "$out" -name 'propagated-build-inputs'); do
          cat "$i" >> "$out/nix-support/propagated-build-inputs"
        done
      '';
    in
    {
      inherit pname;
      version = "${args.version or (getVersion basePackage)}${
        if versionSuffix != "" then "-${versionSuffix}" else ""
      }";

      __structuredAttrs = args.__structuredAttrs or true;

      nativeBuildInputs = args.nativeBuildInputs or [ ] ++ [
        makeBinaryWrapper
        xorg.lndir
      ];

      dontUnpack = args.dontUnpack or true;
      strictDeps = args.strictDeps or true;
      dontRewriteSymlinks = args.dontRewriteSymlinks or true;

      wrapperArgs = [
        "--set-default"
        "VIMINIT"
        "source ${config}/init.lua"

        "--set-default"
        "NVIM_APPNAME"
        pname
      ] ++ args.wrapperArgs or [ ];

      buildPhase =
        args.buildPhase or ''
          runHook preBuild

          mkdir -p $out
          lndir -silent ${basePackage} $out
          rm -rf $out/share/applications

          runHook postBuild
        '';

      installPhase =
        args.installPhase or ''
          runHook preInstall

          wrapProgram $out/bin/nvim "''${wrapperArgs[@]}"
          ln -s $out/bin/nvim $out/bin/${pname}

          runHook postInstall
        '';

      passthru = {
        inherit config;
      } // args.passthru or { };

      meta =
        basePackage.meta
        // {
          priority = (basePackage.meta.priority or defaultPriority) - 1;
        }
        // args.meta or { };
    };
}
