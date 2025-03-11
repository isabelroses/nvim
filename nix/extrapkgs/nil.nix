{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nixVersions,
  fetchpatch,
  nix-update-script,
}:
rustPlatform.buildRustPackage rec {
  pname = "nil";
  version = "2024-08-06";

  src = fetchFromGitHub {
    owner = "oxalica";
    repo = "nil";
    rev = "577d160da311cc7f5042038456a0713e9863d09e";
    hash = "sha256-ggXU3RHv6NgWw+vc+HO4/9n0GPufhTIUjVuLci8Za8c=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-uZsLlFU9GKLvFllF7Kf5Q7HfN26KQojf4rvOb9p7Rjs=";

  nativeBuildInputs = [
    (lib.getBin nixVersions.latest)
  ];

  env.CFG_RELEASE = version;

  patchs = [
    (fetchpatch {
      url = "https://patch-diff.githubusercontent.com/raw/oxalica/nil/pull/157.patch";
      hash = "sha256-4Ex0oy6Hppg4uBZnlvJijDm39juJ7Q/mP1a2ujyy8Ho=";
    })
    (fetchpatch {
      url = "https://patch-diff.githubusercontent.com/raw/oxalica/nil/pull/159.patch";
      hash = "sha256-XcPxeMF6HynBG3zKsIHYbEzB0UHE2yXL9UHNLA5aRJo=";
    })
  ];

  preBuild = ''
    export NIX_STATE_DIR=$(mktemp -d)
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = with lib; {
    description = "Yet another language server for Nix";
    homepage = "https://github.com/oxalica/nil";
    changelog = "https://github.com/oxalica/nil/releases/tag/${version}";
    license = with licenses; [
      mit
      asl20
    ];
    maintainers = with maintainers; [
      figsoda
      oxalica
    ];
    mainProgram = "nil";
  };
}
