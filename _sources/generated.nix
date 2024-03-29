# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alpha-nvim = {
    pname = "alpha-nvim";
    version = "41283fb402713fc8b327e60907f74e46166f4cfd";
    src = fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "41283fb402713fc8b327e60907f74e46166f4cfd";
      fetchSubmodules = false;
      sha256 = "sha256-kTVPKZ/e1us/uHfSwFwR38lFYN8EotJq2jKz6xm/eqg=";
    };
    date = "2024-02-25";
  };
  catppuccin = {
    pname = "catppuccin";
    version = "f66654d5d5190865333e8e46474c1593302c558e";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "f66654d5d5190865333e8e46474c1593302c558e";
      fetchSubmodules = false;
      sha256 = "sha256-gJb3iEkp+l8lVeeSOI0TCrperJ5xgfTPJdp8O1b1OYo=";
    };
    date = "2024-03-27";
  };
  charm-freeze-nvim = {
    pname = "charm-freeze-nvim";
    version = "46139fbc3cb63bb6ed53c216ae0ed8f742a6b5d5";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "charm-freeze.nvim";
      rev = "46139fbc3cb63bb6ed53c216ae0ed8f742a6b5d5";
      fetchSubmodules = false;
      sha256 = "sha256-Q9KEYcH7gWaIi44IzUtsF//FvhSqwRSqlBwx62s2sXo=";
    };
    date = "2024-03-28";
  };
  cloak = {
    pname = "cloak";
    version = "6e5bcd50bebc5cdb7cd3a00eb3d97ab7c4cc3b94";
    src = fetchFromGitHub {
      owner = "laytan";
      repo = "cloak.nvim";
      rev = "6e5bcd50bebc5cdb7cd3a00eb3d97ab7c4cc3b94";
      fetchSubmodules = false;
      sha256 = "sha256-26KBnomSq8zmEZDdGg+jKXj5Q+SAO+7zHiI9V6fX9K4=";
    };
    date = "2024-03-23";
  };
  cmp-buffer = {
    pname = "cmp-buffer";
    version = "3022dbc9166796b644a841a02de8dd1cc1d311fa";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-buffer";
      rev = "3022dbc9166796b644a841a02de8dd1cc1d311fa";
      fetchSubmodules = false;
      sha256 = "sha256-dG4U7MtnXThoa/PD+qFtCt76MQ14V1wX8GMYcvxEnbM=";
    };
    date = "2022-08-10";
  };
  cmp-cmdline = {
    pname = "cmp-cmdline";
    version = "d250c63aa13ead745e3a40f61fdd3470efde3923";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-cmdline";
      rev = "d250c63aa13ead745e3a40f61fdd3470efde3923";
      fetchSubmodules = false;
      sha256 = "sha256-iBmXp+gUSMbgfkv7c7RDQAwPq02e07wEnBETP0dWBOo=";
    };
    date = "2024-03-22";
  };
  cmp-nvim-lsp = {
    pname = "cmp-nvim-lsp";
    version = "5af77f54de1b16c34b23cba810150689a3a90312";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      rev = "5af77f54de1b16c34b23cba810150689a3a90312";
      fetchSubmodules = false;
      sha256 = "sha256-/0sh9vJBD9pUuD7q3tNSQ1YLvxFMNykdg5eG+LjZAA8=";
    };
    date = "2023-12-10";
  };
  cmp-path = {
    pname = "cmp-path";
    version = "91ff86cd9c29299a64f968ebb45846c485725f23";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-path";
      rev = "91ff86cd9c29299a64f968ebb45846c485725f23";
      fetchSubmodules = false;
      sha256 = "sha256-thppiiV3wjIaZnAXmsh7j3DUc6ceSCvGzviwFUnoPaI=";
    };
    date = "2022-10-03";
  };
  cmp_luasnip = {
    pname = "cmp_luasnip";
    version = "05a9ab28b53f71d1aece421ef32fee2cb857a843";
    src = fetchFromGitHub {
      owner = "saadparwaiz1";
      repo = "cmp_luasnip";
      rev = "05a9ab28b53f71d1aece421ef32fee2cb857a843";
      fetchSubmodules = false;
      sha256 = "sha256-nUJJl2zyK/oSwz5RzI9j3gf9zpDfCImCYbPbVsyXgz8=";
    };
    date = "2023-10-09";
  };
  comment = {
    pname = "comment";
    version = "0236521ea582747b58869cb72f70ccfa967d2e89";
    src = fetchFromGitHub {
      owner = "numtostr";
      repo = "comment.nvim";
      rev = "0236521ea582747b58869cb72f70ccfa967d2e89";
      fetchSubmodules = false;
      sha256 = "sha256-+dF1ZombrlO6nQggufSb0igXW5zwU++o0W/5ZA07cdc=";
    };
    date = "2023-08-07";
  };
  copilot-cmp = {
    pname = "copilot-cmp";
    version = "72fbaa03695779f8349be3ac54fa8bd77eed3ee3";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot-cmp";
      rev = "72fbaa03695779f8349be3ac54fa8bd77eed3ee3";
      fetchSubmodules = false;
      sha256 = "sha256-srgNohm/aJpswNJ5+T7p+zi9Jinp9e5FA8/wdk6VRiY=";
    };
    date = "2023-09-09";
  };
  copilot-lua = {
    pname = "copilot-lua";
    version = "f7612f5af4a7d7615babf43ab1e67a2d790c13a6";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "f7612f5af4a7d7615babf43ab1e67a2d790c13a6";
      fetchSubmodules = false;
      sha256 = "sha256-JX3sdsnOnjkY7r9fCtC2oauo0PXF3SQ+SHUo8ifBvAc=";
    };
    date = "2024-02-27";
  };
  crates = {
    pname = "crates";
    version = "b4f4987ccdb1cc3899ee541ef4375c73c48c4570";
    src = fetchFromGitHub {
      owner = "saecki";
      repo = "crates.nvim";
      rev = "b4f4987ccdb1cc3899ee541ef4375c73c48c4570";
      fetchSubmodules = false;
      sha256 = "sha256-wfwSHuP05PEqCbpEG7GStGElMLkrDEbPW7V6p1EANGU=";
    };
    date = "2024-03-13";
  };
  direnv-vim = {
    pname = "direnv-vim";
    version = "ab2a7e08dd630060cd81d7946739ac7442a4f269";
    src = fetchFromGitHub {
      owner = "direnv";
      repo = "direnv.vim";
      rev = "ab2a7e08dd630060cd81d7946739ac7442a4f269";
      fetchSubmodules = false;
      sha256 = "sha256-Lwwm95UEkS8Q0Qsoh10o3sFn48wf7v7eCX/FJJV1HMI=";
    };
    date = "2023-12-02";
  };
  editorconfig = {
    pname = "editorconfig";
    version = "5b9e303e1d6f7abfe616ce4cc8d3fffc554790bf";
    src = fetchFromGitHub {
      owner = "gpanders";
      repo = "editorconfig.nvim";
      rev = "5b9e303e1d6f7abfe616ce4cc8d3fffc554790bf";
      fetchSubmodules = false;
      sha256 = "sha256-pR57tITdVGF4luEmmRYv/XFb35E3KDfcgYRijkPAc+Y=";
    };
    date = "2023-01-10";
  };
  fidget = {
    pname = "fidget";
    version = "2f7c08f45639a64a5c0abcf67321d52c3f499ae6";
    src = fetchFromGitHub {
      owner = "j-hui";
      repo = "fidget.nvim";
      rev = "2f7c08f45639a64a5c0abcf67321d52c3f499ae6";
      fetchSubmodules = false;
      sha256 = "sha256-8Gl2Ck4YJGReSEq1Xeh1dpdRq4eImmrxvIHrfxdem3Q=";
    };
    date = "2023-11-09";
  };
  go-nvim = {
    pname = "go-nvim";
    version = "abd282564a31c5dec14e2038ebf04fdac9ea3278";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "go.nvim";
      rev = "abd282564a31c5dec14e2038ebf04fdac9ea3278";
      fetchSubmodules = false;
      sha256 = "sha256-Jvni7cWHl3eSaRkzR42eMJRmkJJ+OVad8MJUx5upVA8=";
    };
    date = "2024-03-27";
  };
  guihua-lua = {
    pname = "guihua-lua";
    version = "f8ef84df19369bd1fcb8c3210a3b9db13026b7bc";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "guihua.lua";
      rev = "f8ef84df19369bd1fcb8c3210a3b9db13026b7bc";
      fetchSubmodules = false;
      sha256 = "sha256-fKljvoExSf1Y+3yOfYoS1+4nyDTmGRKIs+vwkK69VZM=";
    };
    date = "2024-03-24";
  };
  harpoon = {
    pname = "harpoon";
    version = "a38be6e0dd4c6db66997deab71fc4453ace97f9c";
    src = fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "a38be6e0dd4c6db66997deab71fc4453ace97f9c";
      fetchSubmodules = false;
      sha256 = "sha256-RjwNUuKQpLkRBX3F9o25Vqvpu3Ah1TCFQ5Dk4jXhsbI=";
    };
    date = "2024-01-26";
  };
  lazy = {
    pname = "lazy";
    version = "ba58b87ed9c95da9d61e1b8b4da7bf7904e39986";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazy.nvim";
      rev = "ba58b87ed9c95da9d61e1b8b4da7bf7904e39986";
      fetchSubmodules = false;
      sha256 = "sha256-yVzNK3I7ln/L5gp6z5YTenQIVUhTTM0DApy0vBDIr9Y=";
    };
    date = "2024-03-28";
  };
  lazygit = {
    pname = "lazygit";
    version = "0ada6c6e7e138df92f5009b6952f4ac41248305a";
    src = fetchFromGitHub {
      owner = "kdheepak";
      repo = "lazygit.nvim";
      rev = "0ada6c6e7e138df92f5009b6952f4ac41248305a";
      fetchSubmodules = false;
      sha256 = "sha256-8AZzostsIbrw7q4tNwuD4XOP6oJZaV/mpr8HxV/QiMk=";
    };
    date = "2024-03-23";
  };
  lsp-status = {
    pname = "lsp-status";
    version = "54f48eb5017632d81d0fd40112065f1d062d0629";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "lsp-status.nvim";
      rev = "54f48eb5017632d81d0fd40112065f1d062d0629";
      fetchSubmodules = false;
      sha256 = "sha256-gmLeVnDyL8Zf5ZG92tP3mb/LAt438BxFtAi/Xax2zLI=";
    };
    date = "2022-08-03";
  };
  lspkind = {
    pname = "lspkind";
    version = "1735dd5a5054c1fb7feaf8e8658dbab925f4f0cf";
    src = fetchFromGitHub {
      owner = "onsails";
      repo = "lspkind.nvim";
      rev = "1735dd5a5054c1fb7feaf8e8658dbab925f4f0cf";
      fetchSubmodules = false;
      sha256 = "sha256-/QLdBU/Zwmkw1NGuLBD48tvrmIP9d9WHhgcLEQgRTWo=";
    };
    date = "2024-01-11";
  };
  ltex-extra = {
    pname = "ltex-extra";
    version = "42dd3572cb09b52a137e91e515f2dff5eb631b1e";
    src = fetchFromGitHub {
      owner = "barreiroleo";
      repo = "ltex-extra.nvim";
      rev = "42dd3572cb09b52a137e91e515f2dff5eb631b1e";
      fetchSubmodules = false;
      sha256 = "sha256-ekdjF7Bq+DmI96sHlTcXQYR7WmezA7GwEBbTw4V/OcI=";
    };
    date = "2024-02-03";
  };
  lualine = {
    pname = "lualine";
    version = "b5e8bb642138f787a2c1c5aedc2a78cb2cebbd67";
    src = fetchFromGitHub {
      owner = "nvim-lualine";
      repo = "lualine.nvim";
      rev = "b5e8bb642138f787a2c1c5aedc2a78cb2cebbd67";
      fetchSubmodules = false;
      sha256 = "sha256-+2fi58GolO3e0O7+kl+idNeFuTfJA1b5yCBdY2RnVjA=";
    };
    date = "2024-03-21";
  };
  luasnip = {
    pname = "luasnip";
    version = "a7a4b4682c4b3e2ba82b82a4e6e5f5a0e79dec32";
    src = fetchFromGitHub {
      owner = "L3MON4D3";
      repo = "LuaSnip";
      rev = "a7a4b4682c4b3e2ba82b82a4e6e5f5a0e79dec32";
      fetchSubmodules = false;
      sha256 = "sha256-oyMykjBLkk/9S5AutnPKL+DKgfW59TS+kGUE2GsVbHk=";
    };
    date = "2024-03-03";
  };
  neodev = {
    pname = "neodev";
    version = "6a533ed9d3435dcaa456380d833ea04da37ea2ed";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "neodev.nvim";
      rev = "6a533ed9d3435dcaa456380d833ea04da37ea2ed";
      fetchSubmodules = false;
      sha256 = "sha256-rQ36aBEvLCq33qnek9oYFKMCoog5Ap51rI9xb+Rj7xw=";
    };
    date = "2024-03-22";
  };
  neovim-session-manager = {
    pname = "neovim-session-manager";
    version = "d8e1ba3bbcf3fdc6a887bcfbd94c48ae4707b457";
    src = fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-session-manager";
      rev = "d8e1ba3bbcf3fdc6a887bcfbd94c48ae4707b457";
      fetchSubmodules = false;
      sha256 = "sha256-+TDWY8mprJfUp9ZFKbz83to7XW8iiovja22jHms+N1A=";
    };
    date = "2024-02-18";
  };
  null-ls = {
    pname = "null-ls";
    version = "18910d09d21d7df339805343bfe4a2b2e41c057b";
    src = fetchFromGitHub {
      owner = "nvimtools";
      repo = "none-ls.nvim";
      rev = "18910d09d21d7df339805343bfe4a2b2e41c057b";
      fetchSubmodules = false;
      sha256 = "sha256-FjDb53SNILxP9N9l5cJVBocj1ro/9eE8VKgR0Mv5+gs=";
    };
    date = "2024-03-21";
  };
  nvim-cmp = {
    pname = "nvim-cmp";
    version = "97dc716fc914c46577a4f254035ebef1aa72558a";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "97dc716fc914c46577a4f254035ebef1aa72558a";
      fetchSubmodules = false;
      sha256 = "sha256-VFtf1mI1ucClWzsWn+rf+TlC3ZgkYPiHrPTQZci9zrQ=";
    };
    date = "2024-03-24";
  };
  nvim-colorizer-lua = {
    pname = "nvim-colorizer-lua";
    version = "85855b38011114929f4058efc97af1059ab3e41d";
    src = fetchFromGitHub {
      owner = "nvchad";
      repo = "nvim-colorizer.lua";
      rev = "85855b38011114929f4058efc97af1059ab3e41d";
      fetchSubmodules = false;
      sha256 = "sha256-oKvFN2K+ASlPNwj2rhptR/ErYgo6XKBPhXSZotDdCP0=";
    };
    date = "2023-12-23";
  };
  nvim-lspconfig = {
    pname = "nvim-lspconfig";
    version = "6e5c78ebc9936ca74add66bda22c566f951b6ee5";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "6e5c78ebc9936ca74add66bda22c566f951b6ee5";
      fetchSubmodules = false;
      sha256 = "sha256-kLL+kw0TaMA4uWC5Rng+v1Enm4N+Te8he/eU/ijQSvA=";
    };
    date = "2024-03-24";
  };
  nvim-navic = {
    pname = "nvim-navic";
    version = "8649f694d3e76ee10c19255dece6411c29206a54";
    src = fetchFromGitHub {
      owner = "SmiteshP";
      repo = "nvim-navic";
      rev = "8649f694d3e76ee10c19255dece6411c29206a54";
      fetchSubmodules = false;
      sha256 = "sha256-0p5n/V8Jlj9XyxV/fuMwsbQ7oV5m9H2GqZZEA/njxCQ=";
    };
    date = "2023-11-30";
  };
  nvim-notify = {
    pname = "nvim-notify";
    version = "5371f4bfc1f6d3adf4fe9d62cd3a9d44356bfd15";
    src = fetchFromGitHub {
      owner = "rcarriga";
      repo = "nvim-notify";
      rev = "5371f4bfc1f6d3adf4fe9d62cd3a9d44356bfd15";
      fetchSubmodules = false;
      sha256 = "sha256-xJYPOX4YLcWojMCdP1RO22/7FMrbcBQxqxrcVCE2TrU=";
    };
    date = "2024-02-17";
  };
  nvim-tree-lua = {
    pname = "nvim-tree-lua";
    version = "e508bdc4184c33c6d9705c503cf7f0e029601788";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-tree.lua";
      rev = "e508bdc4184c33c6d9705c503cf7f0e029601788";
      fetchSubmodules = false;
      sha256 = "sha256-ErP+zJQzkf0G7Xiv4VihSwin78VePoTDqwv3ECvboGU=";
    };
    date = "2024-03-26";
  };
  nvim-treesitter = {
    pname = "nvim-treesitter";
    version = "23ba63028c6acca29be6462c0a291fc4a1b9eae8";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "23ba63028c6acca29be6462c0a291fc4a1b9eae8";
      fetchSubmodules = false;
      sha256 = "sha256-rtwm8pVsagN4/Cunlt74+BGBx+33xSRi5MwrDFlFepM=";
    };
    date = "2024-03-28";
  };
  nvim-web-devicons = {
    pname = "nvim-web-devicons";
    version = "3ee60deaa539360518eaab93a6c701fe9f4d82ef";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-web-devicons";
      rev = "3ee60deaa539360518eaab93a6c701fe9f4d82ef";
      fetchSubmodules = false;
      sha256 = "sha256-G8URFQdABLf3ptj+9kwSFGXly9D+4lkt3SXfbhVDH6g=";
    };
    date = "2024-03-26";
  };
  obsidian-nvim = {
    pname = "obsidian-nvim";
    version = "c5c40887028366a6417a1aec7292dfe1054d27df";
    src = fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = "c5c40887028366a6417a1aec7292dfe1054d27df";
      fetchSubmodules = false;
      sha256 = "sha256-EBkioWuxdMnmwbrO+wjKjMU8yHOGSbbhnxr//E56rlY=";
    };
    date = "2024-03-27";
  };
  plenary = {
    pname = "plenary";
    version = "8aad4396840be7fc42896e3011751b7609ca4119";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "8aad4396840be7fc42896e3011751b7609ca4119";
      fetchSubmodules = false;
      sha256 = "sha256-wM/FuK24NPEyaWntwT+mi2SuPExC/abXDK9c2WvgUBk=";
    };
    date = "2024-03-25";
  };
  presence = {
    pname = "presence";
    version = "87c857a56b7703f976d3a5ef15967d80508df6e6";
    src = fetchFromGitHub {
      owner = "andweeb";
      repo = "presence.nvim";
      rev = "87c857a56b7703f976d3a5ef15967d80508df6e6";
      fetchSubmodules = false;
      sha256 = "sha256-ZpsunLsn//zYgUtmAm5FqKVueVd/Pa1r55ZDqxCimBk=";
    };
    date = "2023-01-29";
  };
  py_lsp = {
    pname = "py_lsp";
    version = "278db39aedd697613851861b5ea8b0d9138fc06f";
    src = fetchFromGitHub {
      owner = "hallerpatrick";
      repo = "py_lsp.nvim";
      rev = "278db39aedd697613851861b5ea8b0d9138fc06f";
      fetchSubmodules = false;
      sha256 = "sha256-cNvh7A091kdeLoaoz2ysWuNV0BqzTXgjntU/pDZS92U=";
    };
    date = "2024-02-15";
  };
  rainbow-delimiters = {
    pname = "rainbow-delimiters";
    version = "580bc045c7ab3ab3ebd267774038c0d8cc19c789";
    src = fetchFromGitHub {
      owner = "hiphish";
      repo = "rainbow-delimiters.nvim";
      rev = "580bc045c7ab3ab3ebd267774038c0d8cc19c789";
      fetchSubmodules = false;
      sha256 = "sha256-DCwZMWeH9elJC/amq4lmo3Ql+6mitw+xMg59Aj27id8=";
    };
    date = "2024-03-23";
  };
  rustaceanvim = {
    pname = "rustaceanvim";
    version = "c2cdbeca8674e1b1b66ba870ff502bdad55a6d8a";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "rustaceanvim";
      rev = "c2cdbeca8674e1b1b66ba870ff502bdad55a6d8a";
      fetchSubmodules = false;
      sha256 = "sha256-yOjlsbTTB7CxEO+kWhVb4JQD8LPEkJHUDSkYN52h4Is=";
    };
    date = "2024-03-27";
  };
  schemastore = {
    pname = "schemastore";
    version = "4ce271f0db8b5224b4d69a43a75c13f5b4dcba43";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "schemastore.nvim";
      rev = "4ce271f0db8b5224b4d69a43a75c13f5b4dcba43";
      fetchSubmodules = false;
      sha256 = "sha256-sRk93Zic2WURWS1NGjPa9DVP16PAKgTBQ5qEXGXrfuo=";
    };
    date = "2024-03-26";
  };
  telescope = {
    pname = "telescope";
    version = "b22e6f6896cd64b109bd0807a24098d225d5fb49";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "b22e6f6896cd64b109bd0807a24098d225d5fb49";
      fetchSubmodules = false;
      sha256 = "sha256-mimZJmyq5K2x6EkMnR5T6Q1lOy4E3YcDKX0W3OR4JXA=";
    };
    date = "2024-03-28";
  };
  telescope-file-browser = {
    pname = "telescope-file-browser";
    version = "5ee5002373655fd684a4ad0d47a3de876ceacf9a";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-file-browser.nvim";
      rev = "5ee5002373655fd684a4ad0d47a3de876ceacf9a";
      fetchSubmodules = false;
      sha256 = "sha256-zTHOEn+dR5g+2Z8lFnHkD2xrYwZt94GCGMT0Vz0KIqs=";
    };
    date = "2024-03-24";
  };
  telescope-project = {
    pname = "telescope-project";
    version = "1aaf16580a614601a7f7077d9639aeb457dc5559";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-project.nvim";
      rev = "1aaf16580a614601a7f7077d9639aeb457dc5559";
      fetchSubmodules = false;
      sha256 = "sha256-touMCltcnqkrQYV1NtNeWLQeFVGt+WM3aIWIdKilA7w=";
    };
    date = "2023-12-01";
  };
  telescope-ui-select = {
    pname = "telescope-ui-select";
    version = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-ui-select.nvim";
      rev = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2";
      fetchSubmodules = false;
      sha256 = "sha256-YRhNmmG4gx9Ht8JwjQfbTjJyTHEuZmtP6lqnhOsk8bE=";
    };
    date = "2023-12-04";
  };
  todo-comments = {
    pname = "todo-comments";
    version = "a7e39ae9e74f2c8c6dc4eea6d40c3971ae84752d";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "todo-comments.nvim";
      rev = "a7e39ae9e74f2c8c6dc4eea6d40c3971ae84752d";
      fetchSubmodules = false;
      sha256 = "sha256-BJNU01iTRDNrPv48fgiJRS+ouaHkoqw2AYXKDRgDzfw=";
    };
    date = "2024-03-27";
  };
  toggleterm = {
    pname = "toggleterm";
    version = "193786e0371e3286d3bc9aa0079da1cd41beaa62";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "toggleterm.nvim";
      rev = "193786e0371e3286d3bc9aa0079da1cd41beaa62";
      fetchSubmodules = false;
      sha256 = "sha256-FJyDxQm2vs9R4WkqAbh6ryCvEABfrLSKRrAGo/qI5jM=";
    };
    date = "2024-02-12";
  };
  trouble = {
    pname = "trouble";
    version = "f1168feada93c0154ede4d1fe9183bf69bac54ea";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "trouble.nvim";
      rev = "f1168feada93c0154ede4d1fe9183bf69bac54ea";
      fetchSubmodules = false;
      sha256 = "sha256-8nLghiueYOtWY7OGVxow9A2G/5lgt+Kt5D8q1xeJvVg=";
    };
    date = "2023-10-18";
  };
  typescript-tools = {
    pname = "typescript-tools";
    version = "c43d9580c3ff5999a1eabca849f807ab33787ea7";
    src = fetchFromGitHub {
      owner = "pmizio";
      repo = "typescript-tools.nvim";
      rev = "c43d9580c3ff5999a1eabca849f807ab33787ea7";
      fetchSubmodules = false;
      sha256 = "sha256-kpdDYVd6uSuJImS9LU5p/vJgtj9tToNBvRTJHpsHyak=";
    };
    date = "2024-01-16";
  };
  undotree = {
    pname = "undotree";
    version = "aa93a7e5890dbbebbc064cd22260721a6db1a196";
    src = fetchFromGitHub {
      owner = "mbbill";
      repo = "undotree";
      rev = "aa93a7e5890dbbebbc064cd22260721a6db1a196";
      fetchSubmodules = false;
      sha256 = "sha256-09/SPj/qdhwGuX7/kPCT+r2AHdxD78BPOPBmIrJNHIQ=";
    };
    date = "2024-03-08";
  };
  vim-fugitive = {
    pname = "vim-fugitive";
    version = "2377e16e6641418565b934990cf49068855987c6";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "2377e16e6641418565b934990cf49068855987c6";
      fetchSubmodules = false;
      sha256 = "sha256-Rg1Q3S3syd62LUSfoqzFbOAs7yHQQRiIg9WOmR3ctUg=";
    };
    date = "2024-03-26";
  };
  vim-just = {
    pname = "vim-just";
    version = "9506b055bcdbb9263cbf9648005a6869ae0df523";
    src = fetchFromGitHub {
      owner = "NoahTheDuke";
      repo = "vim-just";
      rev = "9506b055bcdbb9263cbf9648005a6869ae0df523";
      fetchSubmodules = false;
      sha256 = "sha256-MkT/gJ4nL8ULIAJ1o7pfgZmZTq8EDhDTSpl3WYdkQTY=";
    };
    date = "2024-03-23";
  };
  which-key = {
    pname = "which-key";
    version = "4433e5ec9a507e5097571ed55c02ea9658fb268a";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "which-key.nvim";
      rev = "4433e5ec9a507e5097571ed55c02ea9658fb268a";
      fetchSubmodules = false;
      sha256 = "sha256-uvghPj/teWrRMm09Gh8iQ/LV2nYJw0lmoiZK6L4+1cY=";
    };
    date = "2023-10-20";
  };
}
