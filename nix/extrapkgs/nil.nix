{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nixVersions,
  nix-update-script,
}:
rustPlatform.buildRustPackage rec {
  pname = "nil";
  version = "2024-08-06";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "nil";
    rev = "210ba6684b613eb52ee34f690c347fdbdde69dff";
    hash = "sha256-KcHh3RIQFlL40A9v9v3BEfSc5vNG465u/ISA1fR1Cm0=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-Q4wBZtX77v8CjivCtyw4PdRe4OZbW00iLgExusbHbqc=";

  nativeBuildInputs = [
    (lib.getBin nixVersions.latest)
  ];

  env.CFG_RELEASE = version;

  preBuild = ''
    export NIX_STATE_DIR=$(mktemp -d)
  '';

  passthru.updateScript = nix-update-script { };

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
