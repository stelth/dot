{ config, pkgs, lib, ... }:
let
  leap-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "leap-nvim";
    version = "2022-06-25";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap.nvim";
      rev = "a6072a8e1ed3d655e214721fc804c1eae508665e";
      sha256 = "sha256-eGatUG9aPSYRHVsp/6CH6JlCXDeDen6rw7SnoZ9SdGc=";
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
