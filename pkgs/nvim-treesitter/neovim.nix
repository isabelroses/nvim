{
  callPackage,
  grammars ? [ ],
}:
let
  nvim-treesitter = callPackage ./package.nix { inherit grammars; };
in
nvim-treesitter.passthru.neovim
