# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alpha-nvim = {
    pname = "alpha-nvim";
    version = "b6f4129302db197a7249e67a90de3f2b676de13e";
    src = fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "b6f4129302db197a7249e67a90de3f2b676de13e";
      fetchSubmodules = false;
      sha256 = "sha256-gvPEmjM36Z7Q8K83/0ZVLN6J/2mDfEZJ7cW1u+FWf/8=";
    };
    date = "2024-08-19";
  };
  catppuccin = {
    pname = "catppuccin";
    version = "4fd72a9ab64b393c2c22b168508fd244877fec96";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "4fd72a9ab64b393c2c22b168508fd244877fec96";
      fetchSubmodules = false;
      sha256 = "sha256-aNmnn7Ym3+OnuvSgpke6rw4AkoVfNCpbjV71JF1c9rs=";
    };
    date = "2024-08-20";
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
  copilot-cmp = {
    pname = "copilot-cmp";
    version = "b6e5286b3d74b04256d0a7e3bd2908eabec34b44";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot-cmp";
      rev = "b6e5286b3d74b04256d0a7e3bd2908eabec34b44";
      fetchSubmodules = false;
      sha256 = "sha256-8w9go2SBkI+BrXNadWM8ZxDDfrAnZZJx6RbVHAK4+Pg=";
    };
    date = "2024-06-16";
  };
  copilot-lua = {
    pname = "copilot-lua";
    version = "86537b286f18783f8b67bccd78a4ef4345679625";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "86537b286f18783f8b67bccd78a4ef4345679625";
      fetchSubmodules = false;
      sha256 = "sha256-HC1QZlqEg+RBz/8kjLadafc06UoMAjhh0UO/BWQGMY8=";
    };
    date = "2024-06-14";
  };
  crates = {
    pname = "crates";
    version = "b3b9ac6ed9618955b24bf9adede7530ef608495b";
    src = fetchFromGitHub {
      owner = "saecki";
      repo = "crates.nvim";
      rev = "b3b9ac6ed9618955b24bf9adede7530ef608495b";
      fetchSubmodules = false;
      sha256 = "sha256-DcyQtuLUEuv3rQQylopSirwC/TYx8AWuR5arVJG3Eyc=";
    };
    date = "2024-09-02";
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
    version = "7e031b62f13d8b13eed5a2906d6bf4ea6d44759c";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "evergarden";
      rev = "7e031b62f13d8b13eed5a2906d6bf4ea6d44759c";
      fetchSubmodules = false;
      sha256 = "sha256-IfV+Y58vkFigucrWbyHsv5y8/QHDndD5DuxmjqRmBvY=";
    };
    date = "2024-07-15";
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
  freeze-nvim = {
    pname = "freeze-nvim";
    version = "10c10613b4bb92c0d1cd78848ffe2ef258ff6e6c";
    src = fetchFromGitHub {
      owner = "charm-community";
      repo = "freeze.nvim";
      rev = "10c10613b4bb92c0d1cd78848ffe2ef258ff6e6c";
      fetchSubmodules = false;
      sha256 = "sha256-RULJ6Wg0h+vcEaOrY72xR1DlHZaSqJSvqdWNv9V76+E=";
    };
    date = "2024-09-03";
  };
  go-nvim = {
    pname = "go-nvim";
    version = "8389adb56ab124b75d858df5f87b741eaca7b8b3";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "go.nvim";
      rev = "8389adb56ab124b75d858df5f87b741eaca7b8b3";
      fetchSubmodules = false;
      sha256 = "sha256-3Ue6SaH3VhXUOuHQ9Qo7ISmMoTEpLVY4wnueX8iyhyE=";
    };
    date = "2024-08-28";
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
    version = "18603eb949eba08300799f64027af11ef922283f";
    src = fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "indent-blankline.nvim";
      rev = "18603eb949eba08300799f64027af11ef922283f";
      fetchSubmodules = false;
      sha256 = "sha256-5+RulvASXwO2y8owz+6NbPK925llpkACSjC5TuAnUUk=";
    };
    date = "2024-09-03";
  };
  lazy = {
    pname = "lazy";
    version = "48b52b5cfcf8f88ed0aff8fde573a5cc20b1306d";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazy.nvim";
      rev = "48b52b5cfcf8f88ed0aff8fde573a5cc20b1306d";
      fetchSubmodules = false;
      sha256 = "sha256-qERgCq8exkdVQok72TAU1+xvTiy2wxcjsVwoHE59kOc=";
    };
    date = "2024-08-31";
  };
  lazygit = {
    pname = "lazygit";
    version = "2432b447483f42ff2e18b2d392cb2bb27e495c08";
    src = fetchFromGitHub {
      owner = "kdheepak";
      repo = "lazygit.nvim";
      rev = "2432b447483f42ff2e18b2d392cb2bb27e495c08";
      fetchSubmodules = false;
      sha256 = "sha256-YP3L+IPPiBn7XbNm3022/mssOPSKg7H5z8y0qNsGnVc=";
    };
    date = "2024-08-10";
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
    version = "cff4ae321a91ee3473a92ea1a8c637e3a9510aec";
    src = fetchFromGitHub {
      owner = "onsails";
      repo = "lspkind.nvim";
      rev = "cff4ae321a91ee3473a92ea1a8c637e3a9510aec";
      fetchSubmodules = false;
      sha256 = "sha256-1KK6JhQUtA5mxwRSKU5e3pTQzZwaoAjzycBLx5X/xlA=";
    };
    date = "2024-07-25";
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
    version = "45db5addf8d0a201e1cf247cae4cdce605ad3768";
    src = fetchFromGitHub {
      owner = "L3MON4D3";
      repo = "LuaSnip";
      rev = "45db5addf8d0a201e1cf247cae4cdce605ad3768";
      fetchSubmodules = false;
      sha256 = "sha256-1b9hT6+wUoH31JUjWHaBOJMg2juMxoA1vPfme3zBEYg=";
    };
    date = "2024-08-28";
  };
  neocord = {
    pname = "neocord";
    version = "aa7a58023166533da83ca7b11c0d2569e45d7381";
    src = fetchFromGitHub {
      owner = "IogaMaster";
      repo = "neocord";
      rev = "aa7a58023166533da83ca7b11c0d2569e45d7381";
      fetchSubmodules = false;
      sha256 = "sha256-oVWdnQlgXIMzMiybMq7yR/WfEW+Fm5RmhWx0RWprlfQ=";
    };
    date = "2024-04-24";
  };
  neodev = {
    pname = "neodev";
    version = "46aa467dca16cf3dfe27098042402066d2ae242d";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "neodev.nvim";
      rev = "46aa467dca16cf3dfe27098042402066d2ae242d";
      fetchSubmodules = false;
      sha256 = "sha256-hOjzlo/IqmV8tYjGwfmcCPEmHYsWnEIwtHZdhpwA1kM=";
    };
    date = "2024-07-06";
  };
  neovim-session-manager = {
    pname = "neovim-session-manager";
    version = "cbaebd92dce84e9ba63cb07d3199e5a19b204c1a";
    src = fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-session-manager";
      rev = "cbaebd92dce84e9ba63cb07d3199e5a19b204c1a";
      fetchSubmodules = false;
      sha256 = "sha256-HnNbB5Nx65Zb5oTjED0et+bAAEVX5+8pZxwTZvxRtQ8=";
    };
    date = "2024-08-02";
  };
  null-ls = {
    pname = "null-ls";
    version = "9b98991e15dce8fc502993e23caac2528b8b667f";
    src = fetchFromGitHub {
      owner = "nvimtools";
      repo = "none-ls.nvim";
      rev = "9b98991e15dce8fc502993e23caac2528b8b667f";
      fetchSubmodules = false;
      sha256 = "sha256-cL2BRTzxizzPV+FJyWX1286Al39em1eHKdbXTazUlFI=";
    };
    date = "2024-09-01";
  };
  nvim-cmp = {
    pname = "nvim-cmp";
    version = "ae644feb7b67bf1ce4260c231d1d4300b19c6f30";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "ae644feb7b67bf1ce4260c231d1d4300b19c6f30";
      fetchSubmodules = false;
      sha256 = "sha256-NcodgUp8obTsjgc+5j2dKr0f3FelYikQTJngfZXRZzo=";
    };
    date = "2024-08-01";
  };
  nvim-colorizer-lua = {
    pname = "nvim-colorizer-lua";
    version = "194ec600488f7c7229668d0e80bd197f3a2b84ff";
    src = fetchFromGitHub {
      owner = "nvchad";
      repo = "nvim-colorizer.lua";
      rev = "194ec600488f7c7229668d0e80bd197f3a2b84ff";
      fetchSubmodules = false;
      sha256 = "sha256-Qw7IcfM3N+7ml98ExMPBszDz9FwJPtmrVqrVDa0TJKQ=";
    };
    date = "2024-07-25";
  };
  nvim-lspconfig = {
    pname = "nvim-lspconfig";
    version = "0ef64599b8aa0187ee5f6d92cb39c951f348f041";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "0ef64599b8aa0187ee5f6d92cb39c951f348f041";
      fetchSubmodules = false;
      sha256 = "sha256-NT6giuAnG8CbmWjDbBeIkNN3JAWpYtAFw2TXTk6w21Q=";
    };
    date = "2024-09-02";
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
    version = "d333b6f167900f6d9d42a59005d82919830626bf";
    src = fetchFromGitHub {
      owner = "rcarriga";
      repo = "nvim-notify";
      rev = "d333b6f167900f6d9d42a59005d82919830626bf";
      fetchSubmodules = false;
      sha256 = "sha256-wxyHwL/uFdp6w32CVHgSOWkzRrIRuFvWh+J2401RAAA=";
    };
    date = "2024-05-17";
  };
  nvim-tree-lua = {
    pname = "nvim-tree-lua";
    version = "ea55ef12036897fdc4476b115a395d2a34965c82";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-tree.lua";
      rev = "ea55ef12036897fdc4476b115a395d2a34965c82";
      fetchSubmodules = false;
      sha256 = "sha256-25L8/KQorz67Sb6mp5Bm/W1ZPTTC5yqkXJ10cL+jJyg=";
    };
    date = "2024-09-01";
  };
  nvim-treesitter = {
    pname = "nvim-treesitter";
    version = "3826d0c42ac635f560479b5b6ab522f6627a3466";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "3826d0c42ac635f560479b5b6ab522f6627a3466";
      fetchSubmodules = false;
      sha256 = "sha256-6Q3Y4JLZhsXmDv9AQi70GfLmKhv6v5ziIAiJNbEqS+o=";
    };
    date = "2024-09-04";
  };
  nvim-web-devicons = {
    pname = "nvim-web-devicons";
    version = "3722e3d1fb5fe1896a104eb489e8f8651260b520";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-web-devicons";
      rev = "3722e3d1fb5fe1896a104eb489e8f8651260b520";
      fetchSubmodules = false;
      sha256 = "sha256-TeWMlfNTA5+tiPq6D2TVWjdfJVr3FOwpqUDU8kfFZ8E=";
    };
    date = "2024-08-04";
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
    version = "ec289423a1693aeae6cd0d503bac2856af74edaa";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "ec289423a1693aeae6cd0d503bac2856af74edaa";
      fetchSubmodules = false;
      sha256 = "sha256-6Gm+4zZ80quI5iAW6qPAWTq9h1csPWkZFZ9KnFgYRM0=";
    };
    date = "2024-08-19";
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
    version = "5f73b24aeb94f5274c218955573153c69ce4d1ee";
    src = fetchFromGitHub {
      owner = "hiphish";
      repo = "rainbow-delimiters.nvim";
      rev = "5f73b24aeb94f5274c218955573153c69ce4d1ee";
      fetchSubmodules = false;
      sha256 = "sha256-P5AXMUYetOgpPZKO/xF1nJnpIE7tRKWEvfdOLaDBlGM=";
    };
    date = "2024-09-03";
  };
  rustaceanvim = {
    pname = "rustaceanvim";
    version = "3fd3e5c187ad7155d8bf1a689fa5b651407ab22e";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "rustaceanvim";
      rev = "3fd3e5c187ad7155d8bf1a689fa5b651407ab22e";
      fetchSubmodules = false;
      sha256 = "sha256-redx/Dj+R9zTaZLhwYrDtCUL664/ETs9+FQyFGnnPQU=";
    };
    date = "2024-09-04";
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
    version = "c97985bbe5a0988767216f9b54a8e05d70ce8505";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "schemastore.nvim";
      rev = "c97985bbe5a0988767216f9b54a8e05d70ce8505";
      fetchSubmodules = false;
      sha256 = "sha256-9BHkkZ8hjYZw1/SKUPkDHjutc4Jhbr4l/VRveD9p+Sk=";
    };
    date = "2024-09-02";
  };
  telescope = {
    pname = "telescope";
    version = "5972437de807c3bc101565175da66a1aa4f8707a";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "5972437de807c3bc101565175da66a1aa4f8707a";
      fetchSubmodules = false;
      sha256 = "sha256-rNzfnORvbKoglt20i/rKmlkysPUBlB89F6dRKgB5MKU=";
    };
    date = "2024-08-15";
  };
  telescope-file-browser = {
    pname = "telescope-file-browser";
    version = "a46780830b576049c675680650f773bedfa8677a";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-file-browser.nvim";
      rev = "a46780830b576049c675680650f773bedfa8677a";
      fetchSubmodules = false;
      sha256 = "sha256-XbUqbArrDArFA88UBEdyG5LWY8IxelqrYw+s6mXNC3w=";
    };
    date = "2024-08-03";
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
    version = "319c01b99b7a8c9ac2066bf0efd4d6ec68fef444";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "todo-comments.nvim";
      rev = "319c01b99b7a8c9ac2066bf0efd4d6ec68fef444";
      fetchSubmodules = false;
      sha256 = "sha256-gZzd+M9WcrBPucSFd/6MOmGqWm9X89+zPGKmF7ggW1k=";
    };
    date = "2024-08-31";
  };
  tree-sitter-nu = {
    pname = "tree-sitter-nu";
    version = "0bb9a602d9bc94b66fab96ce51d46a5a227ab76c";
    src = fetchgit {
      url = "https://github.com/nushell/tree-sitter-nu";
      rev = "0bb9a602d9bc94b66fab96ce51d46a5a227ab76c";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-A5GiOpITOv3H0wytCv6t43buQ8IzxEXrk3gTlOrO0K0=";
    };
    date = "2024-06-13";
  };
  trouble = {
    pname = "trouble";
    version = "6efc446226679fda0547c0fd6a7892fd5f5b15d8";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "trouble.nvim";
      rev = "6efc446226679fda0547c0fd6a7892fd5f5b15d8";
      fetchSubmodules = false;
      sha256 = "sha256-db/riM3Kq+QgGUqRxJHA4HYXJE31276hrUrDj4UhC2g=";
    };
    date = "2024-07-22";
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
    version = "56c684a805fe948936cda0d1b19505b84ad7e065";
    src = fetchFromGitHub {
      owner = "mbbill";
      repo = "undotree";
      rev = "56c684a805fe948936cda0d1b19505b84ad7e065";
      fetchSubmodules = false;
      sha256 = "sha256-UIroW89ALMRdxSkNGU2VPeuXJxR+25wJ+AakRcjwx/s=";
    };
    date = "2024-04-16";
  };
  vim-fugitive = {
    pname = "vim-fugitive";
    version = "1d18c696c4284e9ce9467a5c04d3adf8af43f994";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "1d18c696c4284e9ce9467a5c04d3adf8af43f994";
      fetchSubmodules = false;
      sha256 = "sha256-lFG5zmBPzmDda8LWJ4XjYEpA6QCLOq2hf14qvcHX7Ng=";
    };
    date = "2024-09-02";
  };
  wakatime = {
    pname = "wakatime";
    version = "53bba6bb8342de9cbdafc82142a9b5e82008d858";
    src = fetchFromGitHub {
      owner = "wakatime";
      repo = "vim-wakatime";
      rev = "53bba6bb8342de9cbdafc82142a9b5e82008d858";
      fetchSubmodules = false;
      sha256 = "sha256-CSngCT6nf00nOwwbfze1gsRs+sFjN+uAR9ldZaN3Ags=";
    };
    date = "2024-07-20";
  };
}
