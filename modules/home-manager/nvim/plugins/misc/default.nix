{ config, pkgs, lib, ... }:
let
  leap-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "leap-nvim";
    version = "2022-07-24";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap.nvim";
      rev = "4e6e6afe81052483bf0900dc2bb8882194b7be50";
      sha256 = "sha256-UpAmjD5ib1zRtLg7pEV5+/sh+Zl22b3H+OHY9GDPzrU=";
    };
    meta.homepage = "https://github.com/ggandor/leap.nvim";
  };
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin = comment-nvim;
        file = ./comment.lua;
      })
      dressing-nvim
      (config.lib.vimUtils.pluginWithCfg {
        plugin = git-worktree-nvim;
        file = ./worktree.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = harpoon;
        file = ./harpoon.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = leap-nvim;
        file = ./leap.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = neogit;
        file = ./neogit.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-autopairs;
        file = ./autopairs.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = undotree;
        file = ./undotree.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = vim-matchup;
        file = ./vim-matchup.lua;
      })
      vim-repeat
    ];
  };
}
