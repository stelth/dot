{ config, pkgs, lib, ... }:
let
  leap-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "leap-nvim";
    version = "2022-06-25";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap.nvim";
      rev = "19442875412a7c82fce2ddf548d825b9dc6c48bc";
      sha256 = "sha256-d3HOGuDMcnTRoxrG0QLns1EZsCZqftvg1K6bDwS8pYY=";
    };
    meta.homepage = "https://github.com/ggandor/leap.nvim";
  };
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins;
      [
        (config.lib.vimUtils.pluginWithCfg {
          plugin = leap-nvim;
          file = ./leap.lua;
        })
      ];
  };
}
