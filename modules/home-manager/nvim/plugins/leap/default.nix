{ config, pkgs, lib, ... }:
let
  leap-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "leap-nvim";
    version = "2022-06-25";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap.nvim";
      rev = "1ab9deb88ef8ccf01a359ef5053b7d3804f8425a";
      sha256 = "sha256-UuZvMxBt1FRnKAUo/G5HBLDkRcyQiQhlN+xJ9ti3+Wg=";
    };
    meta.homepage = "https://github.com/ggandor/leap.nvim";
  };
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin = leap-nvim;
        file = ./leap.lua;
      })
      vim-repeat
    ];
  };
}
