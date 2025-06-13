{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix,
  nixfmt-rfc-style,
  nix-update-script,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "nil";
  version = "2025-06-13";

  src = fetchFromGitHub {
    owner = "oxalica";
    repo = "nil";
    rev = "9e4cccb088440c20703d62db9de8d5ae06d4a449";
    hash = "sha256-oxvVAFUO9husnRk6XZcLFLjLWL9z0pW25Fk6kVKwt1c=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-OZIajxv8xNfCGalVw/FUAwWdQzPqfGuDoeRg2E2RR7s=";

  nativeBuildInputs = [ nix ];

  env = {
    CFG_RELEASE = finalAttrs.version;
    CFG_DEFAULT_FORMATTER = lib.getExe nixfmt-rfc-style;
  };

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
