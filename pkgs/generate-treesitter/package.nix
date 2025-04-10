{
  writeShellApplication,
  callPackage,
}:
writeShellApplication {
  name = "generate";
  runtimeInputs = [
    (callPackage ../nvim-treesitter/neovim.nix { })
  ];

  text = ''
    nvim --headless -l ${../nvim-treesitter/generate-nvfetcher.lua}
  '';
}
