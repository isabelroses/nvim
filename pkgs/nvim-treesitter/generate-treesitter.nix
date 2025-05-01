{ callPackage, writeShellApplication }:
writeShellApplication {
  name = "generate";
  runtimeInputs = [
    (callPackage ./neovim.nix { })
  ];

  text = ''
    nvim --headless -l ${./generate-nvfetcher.lua}
  '';
}
