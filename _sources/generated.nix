# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alpha = {
    pname = "alpha";
    version = "bf3c8bb8c02ed3d9644cc5bbc48e2bdc39349cd7";
    src = fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "bf3c8bb8c02ed3d9644cc5bbc48e2bdc39349cd7";
      fetchSubmodules = false;
      sha256 = "sha256-33lhPP1C4TGo0UQJ61bwRHaiOMAB7XNehcZGaFXOPjQ=";
    };
    date = "2024-09-30";
  };
  catppuccin = {
    pname = "catppuccin";
    version = "ea02cc8c3c053c6c1c574e0791d743338e3e788f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "ea02cc8c3c053c6c1c574e0791d743338e3e788f";
      fetchSubmodules = false;
      sha256 = "sha256-xTiNV7qdUpvqUEiDj3EEKEvGSWij+9MwA5Cj1oJzHHw=";
    };
    date = "2024-10-20";
  };
  cloak = {
    pname = "cloak";
    version = "648aca6d33ec011dc3166e7af3b38820d01a71e4";
    src = fetchFromGitHub {
      owner = "laytan";
      repo = "cloak.nvim";
      rev = "648aca6d33ec011dc3166e7af3b38820d01a71e4";
      fetchSubmodules = false;
      sha256 = "sha256-V7oNIu7IBAHqSrgCNoePNUPjQDU9cFThFf7XGIth0sk=";
    };
    date = "2024-06-12";
  };
  cmp = {
    pname = "cmp";
    version = "29fb4854573355792df9e156cb779f0d31308796";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "29fb4854573355792df9e156cb779f0d31308796";
      fetchSubmodules = false;
      sha256 = "sha256-dAsXxv1RtgMc1i5QrR2xqOeK6aRgYNqdYyTXVBXhVJ4=";
    };
    date = "2024-10-21";
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
    version = "39e2eda76828d88b773cc27a3f61d2ad782c922d";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      rev = "39e2eda76828d88b773cc27a3f61d2ad782c922d";
      fetchSubmodules = false;
      sha256 = "sha256-CT1+Z4XJBVsl/RqvJeGmyitD6x7So0ylXvvef5jh7I8=";
    };
    date = "2024-05-17";
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
  copilot-lua = {
    pname = "copilot-lua";
    version = "f8d8d872bb319f640d5177dad5fbf01f7a16d7d0";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "f8d8d872bb319f640d5177dad5fbf01f7a16d7d0";
      fetchSubmodules = false;
      sha256 = "sha256-UY6N2Q+egh+Cn4REZXrSGH9ElWQBedl0n8tWJvGe7vs=";
    };
    date = "2024-10-18";
  };
  crates = {
    pname = "crates";
    version = "8bf8358ee326d5d8c11dcd7ac0bcc9ff97dbc785";
    src = fetchFromGitHub {
      owner = "saecki";
      repo = "crates.nvim";
      rev = "8bf8358ee326d5d8c11dcd7ac0bcc9ff97dbc785";
      fetchSubmodules = false;
      sha256 = "sha256-DIG0MXRTit4iEVoLlgsTK4znjam/QDjeZEpIDn6KHiE=";
    };
    date = "2024-09-26";
  };
  direnv = {
    pname = "direnv";
    version = "3e38d855c764bb1bec230130ed0e026fca54e4c8";
    src = fetchFromGitHub {
      owner = "NotAShelf";
      repo = "direnv.nvim";
      rev = "3e38d855c764bb1bec230130ed0e026fca54e4c8";
      fetchSubmodules = false;
      sha256 = "sha256-nWdAIchqGsWiF0cQ7NwePRa1fpugE8duZKqdBaisrAc=";
    };
    date = "2024-07-08";
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
  evergarden = {
    pname = "evergarden";
    version = "d7adb7e8e1f803176e588a427d7d21e76840bb83";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "evergarden";
      rev = "d7adb7e8e1f803176e588a427d7d21e76840bb83";
      fetchSubmodules = false;
      sha256 = "sha256-/qeQOr/KN3FV6ojw3frecOhZPoiFyKaf0u8pw7uPyZA=";
    };
    date = "2024-10-21";
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
  freeze = {
    pname = "freeze";
    version = "cc8f09454b0ab1904d493f36f39d38528d7fc085";
    src = fetchFromGitHub {
      owner = "charm-community";
      repo = "freeze.nvim";
      rev = "cc8f09454b0ab1904d493f36f39d38528d7fc085";
      fetchSubmodules = false;
      sha256 = "sha256-6UDskHdf4oMQQ6ZwJmuUG21FUOR1yjID8jU8w536dfQ=";
    };
    date = "2024-09-06";
  };
  go-nvim = {
    pname = "go-nvim";
    version = "12ab6ac0fdd03b1ec9ee4e5378dd204f744a55bf";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "go.nvim";
      rev = "12ab6ac0fdd03b1ec9ee4e5378dd204f744a55bf";
      fetchSubmodules = false;
      sha256 = "sha256-cGJNraQjzAPcRiD/lhmOHxV3LMxHwNxBgcboyrHedTI=";
    };
    date = "2024-10-21";
  };
  guihua-lua = {
    pname = "guihua-lua";
    version = "225db770e36aae6a1e9e3a65578095c8eb4038d3";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "guihua.lua";
      rev = "225db770e36aae6a1e9e3a65578095c8eb4038d3";
      fetchSubmodules = false;
      sha256 = "sha256-V5rlORFlhgjAT0n+LcpMNdY+rEqQpur/KGTGH6uFxMY=";
    };
    date = "2024-06-05";
  };
  harpoon = {
    pname = "harpoon";
    version = "0378a6c428a0bed6a2781d459d7943843f374bce";
    src = fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "0378a6c428a0bed6a2781d459d7943843f374bce";
      fetchSubmodules = false;
      sha256 = "sha256-FZQH38E02HuRPIPAog/nWM55FuBxKp8AyrEldFkoLYk=";
    };
    date = "2024-04-09";
  };
  indent-blankline = {
    pname = "indent-blankline";
    version = "e7a4442e055ec953311e77791546238d1eaae507";
    src = fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "indent-blankline.nvim";
      rev = "e7a4442e055ec953311e77791546238d1eaae507";
      fetchSubmodules = false;
      sha256 = "sha256-OKtaibgT9uPQQmddfj7YKgAYc7lz4ne1dbUz9PdRAvA=";
    };
    date = "2024-10-07";
  };
  lazydev = {
    pname = "lazydev";
    version = "491452cf1ca6f029e90ad0d0368848fac717c6d2";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazydev.nvim";
      rev = "491452cf1ca6f029e90ad0d0368848fac717c6d2";
      fetchSubmodules = false;
      sha256 = "sha256-D5gP2rVPYoWc8hslTrH7Z90cE7XEu+tfkD6FZzY/iPk=";
    };
    date = "2024-07-25";
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
    version = "59c3f419af48a2ffb2320cea85e44e5a95f71664";
    src = fetchFromGitHub {
      owner = "onsails";
      repo = "lspkind.nvim";
      rev = "59c3f419af48a2ffb2320cea85e44e5a95f71664";
      fetchSubmodules = false;
      sha256 = "sha256-72j9A16OGm90eL/iQPEuNSvFh7mSUMKQhbTGpSjbnKM=";
    };
    date = "2024-09-26";
  };
  ltex-extra = {
    pname = "ltex-extra";
    version = "24acd044ce7a26b3cdb537cbd094de37c3e1ac45";
    src = fetchFromGitHub {
      owner = "barreiroleo";
      repo = "ltex-extra.nvim";
      rev = "24acd044ce7a26b3cdb537cbd094de37c3e1ac45";
      fetchSubmodules = false;
      sha256 = "sha256-OGeeEIF+z03DdJO2d2kzQ0lZnIYLabp6irYPqYgbCbc=";
    };
    date = "2024-06-15";
  };
  lualine = {
    pname = "lualine";
    version = "b431d228b7bbcdaea818bdc3e25b8cdbe861f056";
    src = fetchFromGitHub {
      owner = "nvim-lualine";
      repo = "lualine.nvim";
      rev = "b431d228b7bbcdaea818bdc3e25b8cdbe861f056";
      fetchSubmodules = false;
      sha256 = "sha256-gCm7m96PkZyrgjmt7Efc+NMZKStAq1zr7JRCYOgGDuE=";
    };
    date = "2024-08-12";
  };
  luasnip = {
    pname = "luasnip";
    version = "ac7cbc0e85710db7cba6510b1d8e6a1a551444f7";
    src = fetchFromGitHub {
      owner = "L3MON4D3";
      repo = "LuaSnip";
      rev = "ac7cbc0e85710db7cba6510b1d8e6a1a551444f7";
      fetchSubmodules = false;
      sha256 = "sha256-XV4tpI7nmIY0zaoufZsgK6tsmSk7p7fi/P3tPKpb+AA=";
    };
    date = "2024-10-21";
  };
  lz-n = {
    pname = "lz-n";
    version = "f78f791e7be24c3ec59278c1c194ed3208f116dd";
    src = fetchFromGitHub {
      owner = "nvim-neorocks";
      repo = "lz.n";
      rev = "f78f791e7be24c3ec59278c1c194ed3208f116dd";
      fetchSubmodules = false;
      sha256 = "sha256-0w/UmtI7qDpxEElMV7ycs2c37OXj9jJTYzyqYCKqZPY=";
    };
    date = "2024-10-24";
  };
  markview = {
    pname = "markview";
    version = "67b69cdaf9055bebac3682a070d7e5c8eecba29c";
    src = fetchFromGitHub {
      owner = "OXY2DEV";
      repo = "markview.nvim";
      rev = "67b69cdaf9055bebac3682a070d7e5c8eecba29c";
      fetchSubmodules = false;
      sha256 = "sha256-ga7GI2td1mRR6J63+//9neaEnc09TGyMnZrLpP6HGd0=";
    };
    date = "2024-10-09";
  };
  mini-surround = {
    pname = "mini-surround";
    version = "48a9795c9d352c771e1ab5dedab6063c0a2df037";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.surround";
      rev = "48a9795c9d352c771e1ab5dedab6063c0a2df037";
      fetchSubmodules = false;
      sha256 = "sha256-Rzg2yYbOAjOPVNEiUv5qOBObqO1bcDsAgc5ned9HZQw=";
    };
    date = "2024-10-15";
  };
  neovim-session-manager = {
    pname = "neovim-session-manager";
    version = "ce43f2eb2a52492157d7742e5f684b9a42bb3e5c";
    src = fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-session-manager";
      rev = "ce43f2eb2a52492157d7742e5f684b9a42bb3e5c";
      fetchSubmodules = false;
      sha256 = "sha256-W9jtfVXHC8MQJwdbxakNqhd+xh/auQb3U09XKdN2Wzw=";
    };
    date = "2024-10-09";
  };
  null-ls = {
    pname = "null-ls";
    version = "dcc8cd4efdcb29275681a3c95786a816330dbca6";
    src = fetchFromGitHub {
      owner = "nvimtools";
      repo = "none-ls.nvim";
      rev = "dcc8cd4efdcb29275681a3c95786a816330dbca6";
      fetchSubmodules = false;
      sha256 = "sha256-QHvusRnuK/Xq+4AqcIfu84+/iRTMuaYiLCLqrtrhRNk=";
    };
    date = "2024-10-17";
  };
  nvim-colorizer = {
    pname = "nvim-colorizer";
    version = "0671e0eabc6842676d3310370e8fae4e1c51d7f9";
    src = fetchFromGitHub {
      owner = "nvchad";
      repo = "nvim-colorizer.lua";
      rev = "0671e0eabc6842676d3310370e8fae4e1c51d7f9";
      fetchSubmodules = false;
      sha256 = "sha256-Ffi1Q5+AI+Ysi2T56myGWmAzzyq6wW0J/Pwoc3B0ncY=";
    };
    date = "2024-09-11";
  };
  nvim-lspconfig = {
    pname = "nvim-lspconfig";
    version = "0d62a16429dba5fded93a076237079b81527e8f3";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "0d62a16429dba5fded93a076237079b81527e8f3";
      fetchSubmodules = false;
      sha256 = "sha256-/5gFgpWNik17gdi6cLcm/CTGiWQqfZJkZ7G/lZ3hpFA=";
    };
    date = "2024-10-22";
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
    version = "fbef5d32be8466dd76544a257d3f3dce20082a07";
    src = fetchFromGitHub {
      owner = "rcarriga";
      repo = "nvim-notify";
      rev = "fbef5d32be8466dd76544a257d3f3dce20082a07";
      fetchSubmodules = false;
      sha256 = "sha256-Sd7IR5roXHOKRCxhqtYMhWfEltyRJMDEMDO/ecSKenE=";
    };
    date = "2024-09-22";
  };
  nvim-tree = {
    pname = "nvim-tree";
    version = "2a268f631da85e83b7a95291be589bcddfc785d8";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-tree.lua";
      rev = "2a268f631da85e83b7a95291be589bcddfc785d8";
      fetchSubmodules = false;
      sha256 = "sha256-BSvb7C48p9KLC1XB811xrFGlEwZZPwRspdrR5NTwRE0=";
    };
    date = "2024-10-18";
  };
  nvim-treesitter = {
    pname = "nvim-treesitter";
    version = "bab7b0f20bd3e805b77231a77f516c7d69382693";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "bab7b0f20bd3e805b77231a77f516c7d69382693";
      fetchSubmodules = false;
      sha256 = "sha256-KPNMRAks5CyixR1eBZJ838CMnEE4jxH1bILv9mqwChI=";
    };
    date = "2024-10-22";
  };
  nvim-web-devicons = {
    pname = "nvim-web-devicons";
    version = "19d257cf889f79f4022163c3fbb5e08639077bd8";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-web-devicons";
      rev = "19d257cf889f79f4022163c3fbb5e08639077bd8";
      fetchSubmodules = false;
      sha256 = "sha256-SUWEOp+QcfHjYaqqr4Zwvh0x91IAJXvrdMkQtuWMlGc=";
    };
    date = "2024-10-11";
  };
  obsidian-nvim = {
    pname = "obsidian-nvim";
    version = "14e0427bef6c55da0d63f9a313fd9941be3a2479";
    src = fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = "14e0427bef6c55da0d63f9a313fd9941be3a2479";
      fetchSubmodules = false;
      sha256 = "sha256-mbq7fAPmlwOAbWlN3lGX9WGBKTV8cAPZx8pnRCyszJc=";
    };
    date = "2024-08-01";
  };
  plenary = {
    pname = "plenary";
    version = "2d9b06177a975543726ce5c73fca176cedbffe9d";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "2d9b06177a975543726ce5c73fca176cedbffe9d";
      fetchSubmodules = false;
      sha256 = "sha256-bmmPekAvuBvLQmrnnX0n+FRBqfVxBsObhxIEkDGAla4=";
    };
    date = "2024-09-17";
  };
  py_lsp = {
    pname = "py_lsp";
    version = "db01c2d7695a894bfbe5f942b14f798406af5345";
    src = fetchFromGitHub {
      owner = "hallerpatrick";
      repo = "py_lsp.nvim";
      rev = "db01c2d7695a894bfbe5f942b14f798406af5345";
      fetchSubmodules = false;
      sha256 = "sha256-OUk3G1i68cq/B3+Q7/Vl5xN3A+A0EeL9Ys1WlYM95E0=";
    };
    date = "2024-08-12";
  };
  rainbow-delimiters = {
    pname = "rainbow-delimiters";
    version = "d227e6c9879bb50af35cd733461198666981d482";
    src = fetchFromGitHub {
      owner = "hiphish";
      repo = "rainbow-delimiters.nvim";
      rev = "d227e6c9879bb50af35cd733461198666981d482";
      fetchSubmodules = false;
      sha256 = "sha256-3Wovs/DREnbch7BtkmQeTXsb91AbZdb+N8TAVikbd88=";
    };
    date = "2024-09-26";
  };
  rustaceanvim = {
    pname = "rustaceanvim";
    version = "f9b22ae03946a1938288400841cb62ec53077973";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "rustaceanvim";
      rev = "f9b22ae03946a1938288400841cb62ec53077973";
      fetchSubmodules = false;
      sha256 = "sha256-G/sp/G+ch1AJTpDCEV4Kpc5yp322Muss0niVwdEywYA=";
    };
    date = "2024-10-21";
  };
  sayama-nvim = {
    pname = "sayama-nvim";
    version = "39175a766dfc80324d3130d27c3e7922f826226e";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "sayama.nvim";
      rev = "39175a766dfc80324d3130d27c3e7922f826226e";
      fetchSubmodules = false;
      sha256 = "sha256-Rxjg6RvcN5JOP5CTv7Jj7AQJv36zRMaHiFEwhiBVgfw=";
    };
    date = "2024-05-30";
  };
  schemastore = {
    pname = "schemastore";
    version = "3e54f4bbebea598646b141aa8aeca8a01b6ba601";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "schemastore.nvim";
      rev = "3e54f4bbebea598646b141aa8aeca8a01b6ba601";
      fetchSubmodules = false;
      sha256 = "sha256-QnW2yJpn5OIaGC8fW+VymKNAnOvnCSc5hfEWruYwksA=";
    };
    date = "2024-10-21";
  };
  telescope = {
    pname = "telescope";
    version = "df534c3042572fb958586facd02841e10186707c";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "df534c3042572fb958586facd02841e10186707c";
      fetchSubmodules = false;
      sha256 = "sha256-HWNfj3/b+CUFgWR26IzAuMzlSCEuiK/7n8tWHwqAAik=";
    };
    date = "2024-10-10";
  };
  telescope-file-browser = {
    pname = "telescope-file-browser";
    version = "3b8a1e17187cfeedb31decbd625da62398a8ff34";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-file-browser.nvim";
      rev = "3b8a1e17187cfeedb31decbd625da62398a8ff34";
      fetchSubmodules = false;
      sha256 = "sha256-44o8sapjIdIJ+UJJH3X8mUcQjWXzOEI05kCFiVQrlO4=";
    };
    date = "2024-09-21";
  };
  telescope-project = {
    pname = "telescope-project";
    version = "796200876bb0fe8157b8eb1ce03d927d3827a052";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-project.nvim";
      rev = "796200876bb0fe8157b8eb1ce03d927d3827a052";
      fetchSubmodules = false;
      sha256 = "sha256-wO/cm5PT1L0hFr/CX466w0UimoFg/tWrDK8T0QeKZMU=";
    };
    date = "2024-09-09";
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
  tiny-devicons-auto-colors-nvim = {
    pname = "tiny-devicons-auto-colors-nvim";
    version = "a39fa4c92268832f6034306793b8acbfec2a7549";
    src = fetchFromGitHub {
      owner = "rachartier";
      repo = "tiny-devicons-auto-colors.nvim";
      rev = "a39fa4c92268832f6034306793b8acbfec2a7549";
      fetchSubmodules = false;
      sha256 = "sha256-Ndkbvxn/x7+fxEYD7JIygqUiItuhoY+4+DaL/pJGKdc=";
    };
    date = "2024-08-23";
  };
  todo-comments = {
    pname = "todo-comments";
    version = "ae0a2afb47cf7395dc400e5dc4e05274bf4fb9e0";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "todo-comments.nvim";
      rev = "ae0a2afb47cf7395dc400e5dc4e05274bf4fb9e0";
      fetchSubmodules = false;
      sha256 = "sha256-EH4Sy7qNkzOgA1INFzrtsRfD79TgMqSbKUdundyw22w=";
    };
    date = "2024-09-16";
  };
  toggleterm = {
    pname = "toggleterm";
    version = "137d06fb103952a0fb567882bb8527e2f92d327d";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "toggleterm.nvim";
      rev = "137d06fb103952a0fb567882bb8527e2f92d327d";
      fetchSubmodules = false;
      sha256 = "sha256-VlHE5nFHDO6GRRM44TqtcWSk2k0NfeCndp7of/35ta4=";
    };
    date = "2024-08-08";
  };
  trouble = {
    pname = "trouble";
    version = "e45a7cb618ed4e84b28d7478c7db60bad9e142c2";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "trouble.nvim";
      rev = "e45a7cb618ed4e84b28d7478c7db60bad9e142c2";
      fetchSubmodules = false;
      sha256 = "sha256-lQFDS/apk4xpdnSm2LlKeSySik+gEVLsySlxSEezLao=";
    };
    date = "2024-10-22";
  };
  typescript-tools = {
    pname = "typescript-tools";
    version = "f8c2e0b36b651c85f52ad5c5373ff8b07adc15a7";
    src = fetchFromGitHub {
      owner = "pmizio";
      repo = "typescript-tools.nvim";
      rev = "f8c2e0b36b651c85f52ad5c5373ff8b07adc15a7";
      fetchSubmodules = false;
      sha256 = "sha256-8WH/eCff1liDVaezZFvu6RqCtXU4Uwq80BlWiH+tQME=";
    };
    date = "2024-07-18";
  };
  undotree = {
    pname = "undotree";
    version = "78b5241191852ffa9bb5da5ff2ee033160798c3b";
    src = fetchFromGitHub {
      owner = "mbbill";
      repo = "undotree";
      rev = "78b5241191852ffa9bb5da5ff2ee033160798c3b";
      fetchSubmodules = false;
      sha256 = "sha256-XU2n5S2XLIQcPUJESzW+g/ZAXqJo/9uIHYtFutlqmvA=";
    };
    date = "2024-09-18";
  };
  vim-fugitive = {
    pname = "vim-fugitive";
    version = "d4877e54cef67f5af4f950935b1ade19ed6b7370";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "d4877e54cef67f5af4f950935b1ade19ed6b7370";
      fetchSubmodules = false;
      sha256 = "sha256-ArYerBws+MBY4BpKh16J5TfVTrA0OFKPoZq7c2YQjp0=";
    };
    date = "2024-09-06";
  };
  wakatime = {
    pname = "wakatime";
    version = "3cb40867cb5a3120f9bef76eff88edc7f1dc1a23";
    src = fetchFromGitHub {
      owner = "wakatime";
      repo = "vim-wakatime";
      rev = "3cb40867cb5a3120f9bef76eff88edc7f1dc1a23";
      fetchSubmodules = false;
      sha256 = "sha256-HxLmX+qws8A6+mFBGMdru2E3NXJ91P0HtDKMX8ryMzI=";
    };
    date = "2024-04-29";
  };
}
