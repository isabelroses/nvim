{
  SDL2,
  callPackage,
  cargo-bundle,
  clangStdenv,
  darwin,
  enableWayland ? stdenv.isLinux,
  env ? {},
  fontconfig,
  lib,
  libglvnd,
  libxkbcommon,
  makeWrapper,
  pkg-config,
  python3,
  removeReferencesTo,
  rustPlatform,
  stdenv,
  wayland,
  xcbuild,
  xorg,
}: let
  nvfetcher = (callPackage ../../_sources/generated.nix {}).neovide;
  inherit (lib) optionals optionalString;
  inherit (stdenv) isLinux isDarwin;
in
  rustPlatform.buildRustPackage.override {stdenv = clangStdenv;} rec {
    inherit (nvfetcher) pname version src;
    cargoLock = nvfetcher.cargoLock."Cargo.lock";

    nativeBuildInputs =
      [
        cargo-bundle
        makeWrapper
        pkg-config
        python3 # skia
        removeReferencesTo
      ]
      ++ optionals isDarwin [xcbuild];

    doCheck = false;

    buildInputs =
      [
        SDL2
        fontconfig
        rustPlatform.bindgenHook
      ]
      ++ optionals isDarwin [
        darwin.apple_sdk.frameworks.AppKit
      ];

    postBuild = optionalString isDarwin ''
      cargo bundle --release
      mkdir -p "$out/Applications"
      cp -r ./target/release/bundle/osx/Neovide.app "$out/Applications"
    '';

    postFixup = let
      libPath = lib.makeLibraryPath ([
          libglvnd
          libxkbcommon
          xorg.libXcursor
          xorg.libXext
          xorg.libXrandr
          xorg.libXi
        ]
        ++ optionals enableWayland [wayland]);
      toEnv = env:
        with builtins;
          concatStringsSep " " (attrValues (mapAttrs (k: v: "--set ${k} ${toString v}") env));
    in
      ''
        wrapProgram $out/bin/neovide \
          ${toEnv env} \
          --prefix LD_LIBRARY_PATH : ${libPath}
      ''
      + optionalString isDarwin ''
        cp -f "$out/bin/neovide" "$out/Applications/Neovide.app/Contents/MacOS"
      '';

    postInstall = optionalString isLinux ''
      for n in 16x16 32x32 48x48 256x256; do
        install -m444 -D "assets/neovide-$n.png" \
          "$out/share/icons/hicolor/$n/apps/neovide.png"
      done
      install -m444 -Dt $out/share/icons/hicolor/scalable/apps assets/neovide.svg
      install -m444 -Dt $out/share/applications assets/neovide.desktop
    '';

    meta = with lib; {
      description = "This is a simple graphical user interface for Neovim.";
      homepage = "https://github.com/neovide/neovide";
      changelog = "https://github.com/neovide/neovide/releases/tag/${version}";
      license = with licenses; [mit];
    };
  }
