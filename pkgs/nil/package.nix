{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix,
  nix-update-script,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "nil";
  version = "2024-08-06";

  src = fetchFromGitHub {
    owner = "oxalica";
    repo = "nil";
    rev = "58b7742777037fd76fc244e1192433131e05f21c";
    hash = "sha256-qNWrlp36tozupgOeELQ9N5c0nm0iVqufOt21s5GBV5o=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-OZIajxv8xNfCGalVw/FUAwWdQzPqfGuDoeRg2E2RR7s=";

  nativeBuildInputs = [ nix ];

  env.CFG_RELEASE = finalAttrs.version;

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
})
