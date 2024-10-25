{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "fzy-lua-native";
  version = "unstable-2024-10-21";

  src = fetchFromGitHub {
    owner = "romgrk";
    repo = "fzy-lua-native";
    rev = "dacc9db3a3ad270a62dc089520d804894b43aad7";
    hash = "sha256-oPb9i+faFBJx+YLy03pKnq5sBSmIsX+W/TSVO6qYELY=";
  };

  meta = {
    description = "Luajit FFI bindings to FZY";
    homepage = "https://github.com/romgrk/fzy-lua-native";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ isabelroses ];
    mainProgram = "fzy-lua-native";
    platforms = lib.platforms.all;
  };
}
