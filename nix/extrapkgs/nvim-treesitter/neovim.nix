{
  callPackage,
  grammars ? [ ],
}:
let
  nvim-treesitter = callPackage ./default.nix { inherit grammars; };
in
nvim-treesitter.passthru.neovim
