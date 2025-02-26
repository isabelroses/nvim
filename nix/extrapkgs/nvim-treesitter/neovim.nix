{
  callPackage,
  neovim-unwrapped,
  neovimUtils,
  wrapNeovimUnstable,
  grammars ? [ ],
}:
let
  nvim-treesitter = callPackage ./default.nix { inherit grammars; };
in
wrapNeovimUnstable neovim-unwrapped (
  neovimUtils.makeNeovimConfig { plugins = [ nvim-treesitter ]; }
)
