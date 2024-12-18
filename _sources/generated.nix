# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alpha = {
    pname = "alpha";
    version = "de72250e054e5e691b9736ee30db72c65d560771";
    src = fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "de72250e054e5e691b9736ee30db72c65d560771";
      fetchSubmodules = false;
      sha256 = "sha256-sNi5qarejYqM4/J7lBZI3gjVLxer5FBPq8K6qjqcMjA=";
    };
    date = "2024-11-14";
  };
  catppuccin = {
    pname = "catppuccin";
    version = "faf15ab0201b564b6368ffa47b56feefc92ce3f4";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "faf15ab0201b564b6368ffa47b56feefc92ce3f4";
      fetchSubmodules = false;
      sha256 = "sha256-Oogw5wmYkx/zsMlPE/r6Kt3cy5sC92rwVzf0P9rzqyw=";
    };
    as = "catppuccin";
    date = "2024-11-24";
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
    version = "99290b3ec1322070bcfb9e846450a46f6efa50f0";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      rev = "99290b3ec1322070bcfb9e846450a46f6efa50f0";
      fetchSubmodules = false;
      sha256 = "sha256-iaihXNCF5bB5MdeoosD/kc3QtpA/QaIDZVLiLIurBSM=";
    };
    date = "2024-12-10";
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
    version = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90";
    src = fetchFromGitHub {
      owner = "saadparwaiz1";
      repo = "cmp_luasnip";
      rev = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90";
      fetchSubmodules = false;
      sha256 = "sha256-86lKQPPyqFz8jzuLajjHMKHrYnwW6+QOcPyQEx6B+gw=";
    };
    date = "2024-11-04";
  };
  copilot-lua = {
    pname = "copilot-lua";
    version = "d3783b9283a7c35940ed8d71549030d5f5f9f980";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "d3783b9283a7c35940ed8d71549030d5f5f9f980";
      fetchSubmodules = false;
      sha256 = "sha256-XJbgOZRY5WxAvdO8C3eSwaTCc/dBRs9+GnwAoInfj7E=";
    };
    date = "2024-12-11";
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
  evergarden = {
    pname = "evergarden";
    version = "3cd3437ad80883300ee57aeba6116229fb988972";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "evergarden";
      rev = "3cd3437ad80883300ee57aeba6116229fb988972";
      fetchSubmodules = false;
      sha256 = "sha256-rsZmTs8Dmhya57j46bGf1ZjLWGhFcK5ajurUJnkCBvA=";
    };
    date = "2024-12-09";
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
    version = "0025c3a01cdd2c26760812ba94b1f95e13520b00";
    src = fetchFromGitHub {
      owner = "charm-community";
      repo = "freeze.nvim";
      rev = "0025c3a01cdd2c26760812ba94b1f95e13520b00";
      fetchSubmodules = false;
      sha256 = "sha256-MkvXC3mBbRPisbJFcjGsl2cGVdBnbyiMOJUbcGTzL+0=";
    };
    date = "2024-11-14";
  };
  go-nvim = {
    pname = "go-nvim";
    version = "c6d5ca26377d01c4de1f7bff1cd62c8b43baa6bc";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "go.nvim";
      rev = "c6d5ca26377d01c4de1f7bff1cd62c8b43baa6bc";
      fetchSubmodules = false;
      sha256 = "sha256-rv+4im9kh8VhbDbhoMLaUBD4pYKEfkUUPw/6R9EzqO8=";
    };
    date = "2024-12-01";
  };
  guihua-lua = {
    pname = "guihua-lua";
    version = "d783191eaa75215beae0c80319fcce5e6b3beeda";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "guihua.lua";
      rev = "d783191eaa75215beae0c80319fcce5e6b3beeda";
      fetchSubmodules = false;
      sha256 = "sha256-XpUsbj1boDfbyE8C6SdOvZdkd97682VVC81fvQ5WA/4=";
    };
    date = "2024-11-02";
  };
  harpoon = {
    pname = "harpoon";
    version = "a84ab829eaf3678b586609888ef52f7779102263";
    src = fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "a84ab829eaf3678b586609888ef52f7779102263";
      fetchSubmodules = false;
      sha256 = "sha256-PjB64kdmoCD7JfUB7Qz9n34hk0h2/ZZRlN8Jv2Z9HT8=";
    };
    date = "2024-11-12";
  };
  img-clip-nvim = {
    pname = "img-clip-nvim";
    version = "5ff183655ad98b5fc50c55c66540375bbd62438c";
    src = fetchFromGitHub {
      owner = "HakonHarnes";
      repo = "img-clip.nvim";
      rev = "5ff183655ad98b5fc50c55c66540375bbd62438c";
      fetchSubmodules = false;
      sha256 = "sha256-Q4v4E8Iay6rXvtUsM5ULo1cnBYduzTw42kIgJlodq5U=";
    };
    date = "2024-11-26";
  };
  indent-blankline = {
    pname = "indent-blankline";
    version = "259357fa4097e232730341fa60988087d189193a";
    src = fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "indent-blankline.nvim";
      rev = "259357fa4097e232730341fa60988087d189193a";
      fetchSubmodules = false;
      sha256 = "sha256-H3lUQZDvgj3a2STYeMUDiOYPe7rfsy08tJ4SlDd+LuE=";
    };
    date = "2024-12-04";
  };
  lazydev = {
    pname = "lazydev";
    version = "f59bd14a852ca43db38e3662395354cb2a9b13e0";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazydev.nvim";
      rev = "f59bd14a852ca43db38e3662395354cb2a9b13e0";
      fetchSubmodules = false;
      sha256 = "sha256-ErX0dCyAVRn5wtlXVnbEYku2dicIkFySdlsqg5vrWoA=";
    };
    date = "2024-11-25";
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
    version = "d79a1c3299ad0ef94e255d045bed9fa26025dab6";
    src = fetchFromGitHub {
      owner = "onsails";
      repo = "lspkind.nvim";
      rev = "d79a1c3299ad0ef94e255d045bed9fa26025dab6";
      fetchSubmodules = false;
      sha256 = "sha256-OCvKUBGuzwy8OWOL1x3Z3fo+0+GyBMI9TX41xSveqvE=";
    };
    date = "2024-12-05";
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
    version = "2a5bae925481f999263d6f5ed8361baef8df4f83";
    src = fetchFromGitHub {
      owner = "nvim-lualine";
      repo = "lualine.nvim";
      rev = "2a5bae925481f999263d6f5ed8361baef8df4f83";
      fetchSubmodules = false;
      sha256 = "sha256-IN6Qz3jGxUcylYiRTyd8j6me3pAoqJsJXtFUvph/6EI=";
    };
    date = "2024-11-08";
  };
  luasnip = {
    pname = "luasnip";
    version = "33b06d72d220aa56a7ce80a0dd6f06c70cd82b9d";
    src = fetchFromGitHub {
      owner = "L3MON4D3";
      repo = "LuaSnip";
      rev = "33b06d72d220aa56a7ce80a0dd6f06c70cd82b9d";
      fetchSubmodules = false;
      sha256 = "sha256-efDe3RXncnNVkj37AmIv8oj0DKurB50Dziao5FGTLP4=";
    };
    as = "luasnip";
    date = "2024-12-02";
  };
  lz-n = {
    pname = "lz-n";
    version = "3edc2d6061ea2353c90517561f09f357c0670508";
    src = fetchFromGitHub {
      owner = "nvim-neorocks";
      repo = "lz.n";
      rev = "3edc2d6061ea2353c90517561f09f357c0670508";
      fetchSubmodules = false;
      sha256 = "sha256-HfwBit5ZRCY+HVDb11SO2E9ulnMCDcZCfoNIuvZgTPc=";
    };
    start = "true";
    date = "2024-12-15";
  };
  markview = {
    pname = "markview";
    version = "72cd34279e94ee96ee33bdf30a87b00e6d45319d";
    src = fetchFromGitHub {
      owner = "OXY2DEV";
      repo = "markview.nvim";
      rev = "72cd34279e94ee96ee33bdf30a87b00e6d45319d";
      fetchSubmodules = false;
      sha256 = "sha256-4D4jB9CmamMAdpEodw4MdDyJVU6EMsh8P4gLs7p4E40=";
    };
    date = "2024-11-23";
  };
  mini-surround = {
    pname = "mini-surround";
    version = "aa5e245829dd12d8ff0c96ef11da28681d6049aa";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.surround";
      rev = "aa5e245829dd12d8ff0c96ef11da28681d6049aa";
      fetchSubmodules = false;
      sha256 = "sha256-okWJlG0KOdg1ShvkIIMnPSoOzGd7K84eDcp5kx6eVP8=";
    };
    date = "2024-12-08";
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
  none-ls = {
    pname = "none-ls";
    version = "0e1b08168deb6474f7edb842632193685377717b";
    src = fetchFromGitHub {
      owner = "nvimtools";
      repo = "none-ls.nvim";
      rev = "0e1b08168deb6474f7edb842632193685377717b";
      fetchSubmodules = false;
      sha256 = "sha256-w/k2z/erKAs0HrQYKF3bsBNgQa0OQiudWrOOqQ5KyKY=";
    };
    date = "2024-12-17";
  };
  nvim-cmp = {
    pname = "nvim-cmp";
    version = "3403e2e9391ed0a28c3afddd8612701b647c8e26";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "3403e2e9391ed0a28c3afddd8612701b647c8e26";
      fetchSubmodules = false;
      sha256 = "sha256-Aht1m2V+yRvmrLoBC4QGYG/p/tmDbnZe1nT3V5k7S58=";
    };
    date = "2024-12-10";
  };
  nvim-colorizer = {
    pname = "nvim-colorizer";
    version = "4acf88d31b3a7a1a7f31e9c30bf2b23c6313abdb";
    src = fetchFromGitHub {
      owner = "nvchad";
      repo = "nvim-colorizer.lua";
      rev = "4acf88d31b3a7a1a7f31e9c30bf2b23c6313abdb";
      fetchSubmodules = false;
      sha256 = "sha256-lAWeljYC17bmEs1Ss80o6eJYrJ9fsFlKvyJWu9e44XU=";
    };
    date = "2024-11-23";
  };
  nvim-lspconfig = {
    pname = "nvim-lspconfig";
    version = "9f2c279cf9abe584f03bfeb37c6658d68e3ff49d";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "9f2c279cf9abe584f03bfeb37c6658d68e3ff49d";
      fetchSubmodules = false;
      sha256 = "sha256-OQh9dDXsilG/nb8DQ7ZXXqCIO7823QzYa9S8k6tqPIs=";
    };
    date = "2024-12-17";
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
    version = "f7b76cd1a75615c8d6254fc58bedd2a7304eb7d8";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-tree.lua";
      rev = "f7b76cd1a75615c8d6254fc58bedd2a7304eb7d8";
      fetchSubmodules = false;
      sha256 = "sha256-Z5RsV10V4nRlYtvpvGkmCPBo4hCSZg4PFIrTu9NXNuw=";
    };
    date = "2024-12-14";
  };
  nvim-treesitter = {
    pname = "nvim-treesitter";
    version = "981ca7e353da6ea69eaafe4348fda5e800f9e1d8";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "981ca7e353da6ea69eaafe4348fda5e800f9e1d8";
      fetchSubmodules = false;
      sha256 = "sha256-mHbp4giHuGD12ut68fNExmPaj1mtJJqWo9EqZtLlMeM=";
    };
    date = "2024-12-17";
  };
  nvim-web-devicons = {
    pname = "nvim-web-devicons";
    version = "0eb18da56e2ba6ba24de7130a12bcc4e31ad11cb";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-web-devicons";
      rev = "0eb18da56e2ba6ba24de7130a12bcc4e31ad11cb";
      fetchSubmodules = false;
      sha256 = "sha256-OULD8dLI3Oakg9rgs4h8zXozOmX0aiovBNk8kD0nDXY=";
    };
    date = "2024-12-16";
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
    start = "true";
    date = "2024-09-17";
  };
  py_lsp = {
    pname = "py_lsp";
    version = "fe28db286c5cd3feb8e415d9f11cdaaf827e6c5a";
    src = fetchFromGitHub {
      owner = "hallerpatrick";
      repo = "py_lsp.nvim";
      rev = "fe28db286c5cd3feb8e415d9f11cdaaf827e6c5a";
      fetchSubmodules = false;
      sha256 = "sha256-4OH1dBDaiz+bK9oc7Z8qXvUcgARul0FoJQ3gQVT4aFM=";
    };
    date = "2024-11-17";
  };
  quill-nvim = {
    pname = "quill-nvim";
    version = "08103ea02643a93065fe7dbc4ed22275719fc338";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "quill.nvim";
      rev = "08103ea02643a93065fe7dbc4ed22275719fc338";
      fetchSubmodules = false;
      sha256 = "sha256-SDMoqQwY3cKj5c5wHFdE+G0ZWVIeLjF6DU67tfDfi8w=";
    };
    date = "2024-12-10";
  };
  rainbow-delimiters = {
    pname = "rainbow-delimiters";
    version = "77e5bad54227dcfe3878ffbda88ab1efdaacb475";
    src = fetchFromGitHub {
      owner = "hiphish";
      repo = "rainbow-delimiters.nvim";
      rev = "77e5bad54227dcfe3878ffbda88ab1efdaacb475";
      fetchSubmodules = false;
      sha256 = "sha256-qDyEf+SflbDEweK5cZP/YZX4yAw0UGSTWgRai5RC8/I=";
    };
    date = "2024-12-15";
  };
  rustaceanvim = {
    pname = "rustaceanvim";
    version = "0a618c1d1c05a8059880076feccb15301da6993d";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "rustaceanvim";
      rev = "0a618c1d1c05a8059880076feccb15301da6993d";
      fetchSubmodules = false;
      sha256 = "sha256-qmd1yVOG2s5/5ygWF9J6RCmDseI3N72zzW+3uIG/qs8=";
    };
    date = "2024-12-17";
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
    version = "bb03860b59f17dfada46d6d9563c48b7b12fecaf";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "schemastore.nvim";
      rev = "bb03860b59f17dfada46d6d9563c48b7b12fecaf";
      fetchSubmodules = false;
      sha256 = "sha256-5Joek+3d6AEqTmDNuWocp0TusMTHa8RIWvrxQm82Gt0=";
    };
    date = "2024-12-16";
  };
  snacks-nvim = {
    pname = "snacks-nvim";
    version = "972c61cc1cd254ef3b43ec1dfd51eefbdc441a7d";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "snacks.nvim";
      rev = "972c61cc1cd254ef3b43ec1dfd51eefbdc441a7d";
      fetchSubmodules = false;
      sha256 = "sha256-OBig3B2S87Ip9pwp38X3gMH2SHACbNMpMQ3JeAGxqQY=";
    };
    date = "2024-12-17";
  };
  telescope = {
    pname = "telescope";
    version = "2eca9ba22002184ac05eddbe47a7fe2d5a384dfc";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "2eca9ba22002184ac05eddbe47a7fe2d5a384dfc";
      fetchSubmodules = false;
      sha256 = "sha256-npb61MZYAotz71Co5G1dUeIqWt7GVeqZNz0A2Yz2dy4=";
    };
    date = "2024-11-29";
  };
  telescope-project = {
    pname = "telescope-project";
    version = "1d7920e799fc5001dffc7bd10909a86e0358eaf4";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-project.nvim";
      rev = "1d7920e799fc5001dffc7bd10909a86e0358eaf4";
      fetchSubmodules = false;
      sha256 = "sha256-qEORRWYKBpK7fn7se8g+5uuVBJNu0T4JHSc0C2QzNDY=";
    };
    date = "2024-12-01";
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
    version = "87b2d6a3cab8e2bd9a0255427074285f0365398d";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "toggleterm.nvim";
      rev = "87b2d6a3cab8e2bd9a0255427074285f0365398d";
      fetchSubmodules = false;
      sha256 = "sha256-g1FwgCc3a8Fak0Nb0gQQ+SI44uyAGaH1tIk1qpaAPEY=";
    };
    date = "2024-11-09";
  };
  trouble = {
    pname = "trouble";
    version = "46cf952fc115f4c2b98d4e208ed1e2dce08c9bf6";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "trouble.nvim";
      rev = "46cf952fc115f4c2b98d4e208ed1e2dce08c9bf6";
      fetchSubmodules = false;
      sha256 = "sha256-JhnERZfma2JHFEn/DElVmrSU5KxM2asx3SJ+86lCfoo=";
    };
    date = "2024-11-27";
  };
  typescript-tools = {
    pname = "typescript-tools";
    version = "35e397ce467bedbbbb5bfcd0aa79727b59a08d4a";
    src = fetchFromGitHub {
      owner = "pmizio";
      repo = "typescript-tools.nvim";
      rev = "35e397ce467bedbbbb5bfcd0aa79727b59a08d4a";
      fetchSubmodules = false;
      sha256 = "sha256-x32NzZYFK6yovlvE3W8NevYA0UT0qvwKle1irFwmuvM=";
    };
    date = "2024-12-04";
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
    version = "fcb4db52e7f65b95705aa58f0f2df1312c1f2df2";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "fcb4db52e7f65b95705aa58f0f2df1312c1f2df2";
      fetchSubmodules = false;
      sha256 = "sha256-PJewEivZ1sAn2vBhwxfIHE+rAmY+9GYPNqID5zsey8c=";
    };
    date = "2024-12-15";
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
