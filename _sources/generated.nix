# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alpha-nvim = {
    pname = "alpha-nvim";
    version = "1356b9ef31b985d541d94314f2cf73c61124bf1d";
    src = fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "1356b9ef31b985d541d94314f2cf73c61124bf1d";
      fetchSubmodules = false;
      sha256 = "sha256-y15fuINE0FGl5YSSyHZT+jzyE2F+aA42JWqbHhRV9uo=";
    };
    date = "2024-01-30";
  };
  catppuccin = {
    pname = "catppuccin";
    version = "c2034f7b549152e5cc757820426341ea5000bc7a";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "c2034f7b549152e5cc757820426341ea5000bc7a";
      fetchSubmodules = false;
      sha256 = "sha256-qeakoy8iFMqm10rOG62b8se9Ix+6xUD18hBvXhkrMdY=";
    };
    date = "2024-01-31";
  };
  cloak = {
    pname = "cloak";
    version = "9abe4e986e924fc54a972c1b0ff52b65a0622624";
    src = fetchFromGitHub {
      owner = "laytan";
      repo = "cloak.nvim";
      rev = "9abe4e986e924fc54a972c1b0ff52b65a0622624";
      fetchSubmodules = false;
      sha256 = "sha256-fL+qUK22QkNGxbnL8MH+97nl3QkRd8zizHcdJnDv0Eo=";
    };
    date = "2024-02-02";
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
    version = "8ee981b4a91f536f52add291594e89fb6645e451";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-cmdline";
      rev = "8ee981b4a91f536f52add291594e89fb6645e451";
      fetchSubmodules = false;
      sha256 = "sha256-W8v/XhPjbvKSwCrfOAPihO2N9PEVnH5Cp/Fa25lNRw4=";
    };
    date = "2023-06-09";
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
    version = "03f825956ec49e550d07875d867ea6e7c4dc8c00";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "03f825956ec49e550d07875d867ea6e7c4dc8c00";
      fetchSubmodules = false;
      sha256 = "sha256-H8dwtkk5ADagpIXfZ2rL8Giy77cC6daWoSgntO9eh0c=";
    };
    date = "2024-02-04";
  };
  crates = {
    pname = "crates";
    version = "ec2b04a380c9f3a8e6ca38c230e4990d71978143";
    src = fetchFromGitHub {
      owner = "saecki";
      repo = "crates.nvim";
      rev = "ec2b04a380c9f3a8e6ca38c230e4990d71978143";
      fetchSubmodules = false;
      sha256 = "sha256-wYV8GrXQFGdKvdO5asVx7dWBVB4aQ3Bd08nw8fmmf3Q=";
    };
    date = "2024-02-04";
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
    version = "d748e79011437d5b080006b896b3c296656641d7";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "go.nvim";
      rev = "d748e79011437d5b080006b896b3c296656641d7";
      fetchSubmodules = false;
      sha256 = "sha256-ONNHdseDRlxbtGYrjXYo3rsm0t4Tc8/ZtUYI/7aL+fk=";
    };
    date = "2024-02-10";
  };
  guihua-lua = {
    pname = "guihua-lua";
    version = "9fb6795474918b492d9ab01b1ebaf85e8bf6fe0b";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "guihua.lua";
      rev = "9fb6795474918b492d9ab01b1ebaf85e8bf6fe0b";
      fetchSubmodules = false;
      sha256 = "sha256-0fpcYEdWfpy8MatH8cjalGOQ7/tau6ciiuSV1t09BlY=";
    };
    date = "2023-12-06";
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
    version = "aedcd79811d491b60d0a6577a9c1701063c2a609";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazy.nvim";
      rev = "aedcd79811d491b60d0a6577a9c1701063c2a609";
      fetchSubmodules = false;
      sha256 = "sha256-8gbwjDkpXOSiLwv7fIBSZWFPi8kd6jyLMFa3S5BZXdM=";
    };
    date = "2024-01-23";
  };
  lazygit = {
    pname = "lazygit";
    version = "1e08e3f5ac1152339690140e61a4a32b3bdc7de5";
    src = fetchFromGitHub {
      owner = "kdheepak";
      repo = "lazygit.nvim";
      rev = "1e08e3f5ac1152339690140e61a4a32b3bdc7de5";
      fetchSubmodules = false;
      sha256 = "sha256-fYNsHQeG/C6pAy2rHPN5h/bYJRc8IGQ8REKiU9TWQ+c=";
    };
    date = "2023-12-15";
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
    version = "7d131a8d3ba5016229e8a1d08bf8782acea98852";
    src = fetchFromGitHub {
      owner = "nvim-lualine";
      repo = "lualine.nvim";
      rev = "7d131a8d3ba5016229e8a1d08bf8782acea98852";
      fetchSubmodules = false;
      sha256 = "sha256-LMMcRY4qnGywdK6Bl4YeAEKLhnRuOZ2txn4oYoso2gI=";
    };
    date = "2024-01-25";
  };
  luasnip = {
    pname = "luasnip";
    version = "2dbef19461198630b3d7c39f414d09fb07d1fdd2";
    src = fetchFromGitHub {
      owner = "L3MON4D3";
      repo = "LuaSnip";
      rev = "2dbef19461198630b3d7c39f414d09fb07d1fdd2";
      fetchSubmodules = false;
      sha256 = "sha256-TlzIaDERoWt5yOyuCVtqJq3lHEtDsEd0lHKnFcvVqo8=";
    };
    date = "2024-01-17";
  };
  neodev = {
    pname = "neodev";
    version = "a09881379ac7abddb8091c5edd292805a53ccf18";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "neodev.nvim";
      rev = "a09881379ac7abddb8091c5edd292805a53ccf18";
      fetchSubmodules = false;
      sha256 = "sha256-eC13p70Pi6rI25jtiOvuqJebuDgO6psklthln9iCsEo=";
    };
    date = "2024-02-11";
  };
  neovim-session-manager = {
    pname = "neovim-session-manager";
    version = "07bb62583769abd9d32f88f428ea58248730ac7a";
    src = fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-session-manager";
      rev = "07bb62583769abd9d32f88f428ea58248730ac7a";
      fetchSubmodules = false;
      sha256 = "sha256-HB6Vdkg+gKTcg2s/Wfn4xceMazcZw50Bdr5++vAgvSc=";
    };
    date = "2024-01-27";
  };
  null-ls = {
    pname = "null-ls";
    version = "34b1311bd07bd3741e60e06b34d0709d6e5a9f0f";
    src = fetchFromGitHub {
      owner = "nvimtools";
      repo = "none-ls.nvim";
      rev = "34b1311bd07bd3741e60e06b34d0709d6e5a9f0f";
      fetchSubmodules = false;
      sha256 = "sha256-nQCxzlQZgso2rjHLVaASkStQhrC4XUpg3d8/yfrZfR0=";
    };
    date = "2024-02-13";
  };
  nvim-cmp = {
    pname = "nvim-cmp";
    version = "04e0ca376d6abdbfc8b52180f8ea236cbfddf782";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "04e0ca376d6abdbfc8b52180f8ea236cbfddf782";
      fetchSubmodules = false;
      sha256 = "sha256-FF7OHYUC4VFwFvqWKI/R5BSAC0JL6qFKUS6/XRSd9H8=";
    };
    date = "2024-02-02";
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
    version = "ae91a303a2258cb9cd9501e9d20c2dc92792d362";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "ae91a303a2258cb9cd9501e9d20c2dc92792d362";
      fetchSubmodules = false;
      sha256 = "sha256-+mUhVjxir5sF0ldmu+Gky7WmoNvYcfXhfOs6HNJm6rU=";
    };
    date = "2024-02-13";
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
    version = "80b67b265530632505193553d05127ae7fe09ddd";
    src = fetchFromGitHub {
      owner = "rcarriga";
      repo = "nvim-notify";
      rev = "80b67b265530632505193553d05127ae7fe09ddd";
      fetchSubmodules = false;
      sha256 = "sha256-WhC80NnWXEAYHLORpUPIXb2s1ERJxyK3l2L9oke68mo=";
    };
    date = "2024-01-15";
  };
  nvim-tree-lua = {
    pname = "nvim-tree-lua";
    version = "863cf832ceb0b2377c913b7696dd7d64f4978941";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-tree.lua";
      rev = "863cf832ceb0b2377c913b7696dd7d64f4978941";
      fetchSubmodules = false;
      sha256 = "sha256-N/MFJw2sqVCQ3l+w4minzrk3/pcZKZLg9y52PrXZjt0=";
    };
    date = "2024-02-12";
  };
  nvim-treesitter = {
    pname = "nvim-treesitter";
    version = "7e9139db685ae88bf55e224a7b68e02b5dcfcb88";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "7e9139db685ae88bf55e224a7b68e02b5dcfcb88";
      fetchSubmodules = false;
      sha256 = "sha256-vLNBY9ptzAQRd22l/pcPH880C/y3411iFanFHY4XXOw=";
    };
    date = "2024-02-13";
  };
  nvim-web-devicons = {
    pname = "nvim-web-devicons";
    version = "7f30f2da3c3641841ceb0e2c150281f624445e8f";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-web-devicons";
      rev = "7f30f2da3c3641841ceb0e2c150281f624445e8f";
      fetchSubmodules = false;
      sha256 = "sha256-Z2uIDeXKInS6qQZxZrpmCuwpT5h0LEOt/Tc+h0LXOus=";
    };
    date = "2024-02-10";
  };
  obsidian-nvim = {
    pname = "obsidian-nvim";
    version = "0a6739d2229c8eb30396db550f3818e092088c27";
    src = fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = "0a6739d2229c8eb30396db550f3818e092088c27";
      fetchSubmodules = false;
      sha256 = "sha256-VIc5qgzqJjSv2A0v8tM25pWh+smX9DYXVsyFNTGMPbQ=";
    };
    date = "2024-02-13";
  };
  plenary = {
    pname = "plenary";
    version = "4f71c0c4a196ceb656c824a70792f3df3ce6bb6d";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "4f71c0c4a196ceb656c824a70792f3df3ce6bb6d";
      fetchSubmodules = false;
      sha256 = "sha256-AWJHxehKUkEV6N+n78urqHjMVUsMfDK3lvHs/VxhKE8=";
    };
    date = "2024-01-29";
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
    version = "79ee75421de51ff6252fa34ed3316ff894d825d5";
    src = fetchFromGitHub {
      owner = "hallerpatrick";
      repo = "py_lsp.nvim";
      rev = "79ee75421de51ff6252fa34ed3316ff894d825d5";
      fetchSubmodules = false;
      sha256 = "sha256-PPoshU17R3w61BM1JKjVFLMKhgoU/r4rLTG8PEczsTk=";
    };
    date = "2024-01-31";
  };
  rainbow-delimiters = {
    pname = "rainbow-delimiters";
    version = "586f44d21ef687a4d41b5b24c1566d686ae84250";
    src = fetchFromGitHub {
      owner = "hiphish";
      repo = "rainbow-delimiters.nvim";
      rev = "586f44d21ef687a4d41b5b24c1566d686ae84250";
      fetchSubmodules = false;
      sha256 = "sha256-kNnZV06VYE7DhNDbJIHd6MvdX04qFjXgy7OHO1ai6x0=";
    };
    date = "2024-02-12";
  };
  rustaceanvim = {
    pname = "rustaceanvim";
    version = "1e956999e45cda8a65cef625c46102495b3eab40";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "rustaceanvim";
      rev = "1e956999e45cda8a65cef625c46102495b3eab40";
      fetchSubmodules = false;
      sha256 = "sha256-aFgUtt/Ohv2etlbzJoXQcAhiXQ9RglgLk3fLcRudtcM=";
    };
    date = "2024-02-13";
  };
  schemastore = {
    pname = "schemastore";
    version = "91b56a811d87b9e7e0600c95f80ff2d08245bf61";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "schemastore.nvim";
      rev = "91b56a811d87b9e7e0600c95f80ff2d08245bf61";
      fetchSubmodules = false;
      sha256 = "sha256-lRE/djdE0ArNlkP7V9K7zpcCPwdG4WspdZ2ons5wLwA=";
    };
    date = "2024-02-12";
  };
  telescope = {
    pname = "telescope";
    version = "0f865f17af4f9bc1587a0132414cdfd32d91852e";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "0f865f17af4f9bc1587a0132414cdfd32d91852e";
      fetchSubmodules = false;
      sha256 = "sha256-t58sRzxwU7NUkZ2X8fVCaMWRbCqT0ywvm71eiFfMo3Q=";
    };
    date = "2024-02-09";
  };
  telescope-file-browser = {
    pname = "telescope-file-browser";
    version = "26b5e86cb8509a3ca2ebaa652630396c8e3396b2";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-file-browser.nvim";
      rev = "26b5e86cb8509a3ca2ebaa652630396c8e3396b2";
      fetchSubmodules = false;
      sha256 = "sha256-84a34ytPR33JpdWqAcl8SrgqR+eVibvHM/edfgcqeM0=";
    };
    date = "2024-02-09";
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
    version = "833d8dd8b07eeda37a09e99460f72a02616935cb";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "todo-comments.nvim";
      rev = "833d8dd8b07eeda37a09e99460f72a02616935cb";
      fetchSubmodules = false;
      sha256 = "sha256-DiyieXXx7iYGWkpeOvduJf0n7dnpaQ7rXmaWvZQaCyE=";
    };
    date = "2024-01-21";
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
    version = "9dbbf3b7d19dda0d22ceca461818e4739ad8154d";
    src = fetchFromGitHub {
      owner = "mbbill";
      repo = "undotree";
      rev = "9dbbf3b7d19dda0d22ceca461818e4739ad8154d";
      fetchSubmodules = false;
      sha256 = "sha256-ljKXuoc1MFVmZ5xbMdwvbVH8qs7TNDG9veVaxisreqs=";
    };
    date = "2024-02-11";
  };
  vim-fugitive = {
    pname = "vim-fugitive";
    version = "011cf4fcb93a9649ffc6dcdff56ef948f5d0f7cc";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "011cf4fcb93a9649ffc6dcdff56ef948f5d0f7cc";
      fetchSubmodules = false;
      sha256 = "sha256-dI28XbFYUWuGQ89oGR51WK6M3kWhBwqqC0Bs99vxrjY=";
    };
    date = "2024-02-11";
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
