{
  callPackage,
  lib,
  runCommand,
  tree-sitter,
  vimUtils,
  wrapNeovimUnstable,
  neovimUtils,
  neovim-unwrapped,
  grammars ? [ ],
}:
let
  nv = callPackage ./_sources/generated.nix { };
  grammarOverrides = callPackage ./grammar-overrides.nix { };

  # get all grammars from the nvfetcher output
  allGrammars = builtins.map (name: lib.removePrefix "treesitter-grammar-" name) (
    (builtins.attrNames (
      builtins.removeAttrs nv [
        "nvim-treesitter"
        "override"
        "overrideDerivation"
      ]
    ))
  );

  grammarsToBuild = if grammars == [ ] then allGrammars else lib.intersectLists grammars allGrammars;

  # build each Grammar
  treesitterGrammars = builtins.map (
    name:
    let
      nvgrammar = nv."treesitter-grammar-${name}";
    in
    tree-sitter.buildGrammar (
      {
        inherit (nvgrammar) src version;
        language = name;
        generate = lib.hasAttr "generate" nvgrammar;
        location = nvgrammar.location or null;
      }
      // grammarOverrides.${name} or { }
    )
  ) grammarsToBuild;

  linkCommands = builtins.map (
    grammar:
    let
      name = lib.removeSuffix "-grammar" grammar.pname;
    in
    ''
      ln -sf ${grammar}/parser ./parser/${name}.so

      # link queries when they only exist in the grammar repo
      if [[ -d ${grammar}/queries ]] && [[ ! -d ./queries/${name} ]]; then
        ln -sf ${grammar}/queries ./queries/${name}
      fi
    ''
  ) treesitterGrammars;

  # test config for Neovim with the derivation installed as a plugin
  neovim = wrapNeovimUnstable neovim-unwrapped (
    neovimUtils.makeNeovimConfig { plugins = [ nvim-treesitter ]; }
  );

  check-queries =
    runCommand "check-queries"
      {
        nativeBuildInputs = [ neovim ];
        env.CI = true;
      }
      ''
        touch $out
        export HOME=$(mktemp -d)
        ln -s ${nvim-treesitter}/CONTRIBUTING.md .

        nvim --headless "+luafile ${nvim-treesitter}/scripts/check-queries.lua" | tee log

        if grep -q Warning log || grep -q Error log; then
          echo "Error: warnings were emitted by the check"
          exit 1
        fi
      '';

  nvim-treesitter = vimUtils.buildVimPlugin {
    inherit (nv.nvim-treesitter) pname version src;
    postPatch = lib.concatStrings linkCommands;

    passthru = {
      grammars = treesitterGrammars;
      tests = {
        inherit check-queries;
      };
    };
  };
in
(lib.checkListOfEnum "nvim-treesitter: grammars" allGrammars grammars) nvim-treesitter
