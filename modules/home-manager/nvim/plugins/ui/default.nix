{ config, lib, pkgs, ... }:
let
  staline-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "staline-nvim";
    version = "2022-08-03";
    src = pkgs.fetchFromGitHub {
      owner = "tamton-aquib";
      repo = "staline.nvim";
      rev = "3559cb72c035c2aa0fc5d52aade270ab6cc680c3";
      sha256 = "sha256-hAP5n5LaeD1321JY8pEd1nw4zvBn7xkHm2W8wyhuF+I=";
    };
    meta.homepage = "https://github.com/tamton-aquib/staline.nvim";
  };
  fine-cmdline-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "fine-cmdline-nvim";
    version = "2022-07-01";
    src = pkgs.fetchFromGitHub {
      owner = "VonHeikemen";
      repo = "fine-cmdline.nvim";
      rev = "ead2b85e455eacde10469a8fcf1a717822d2bb9a";
      sha256 = "sha256-0aYHz6uRMVjctrDo8JKlTIUP2Oj+MrhBvgXRIwo/ueU=";
    };

    dependencies = with pkgs.vimPlugins; [ nui-nvim ];

    meta.homepage = "https://github.com/VonHeikemen/fine-cmdline.nvim";
  };
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin = fine-cmdline-nvim;
        file = ./fine-cmdline.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = kanagawa-nvim;
        file = ./kanagawa.lua;
      })
      nvim-web-devicons
      (config.lib.vimUtils.pluginWithCfg {
        plugin = staline-nvim;
        file = ./staline.lua;
      })
    ];
  };
}
