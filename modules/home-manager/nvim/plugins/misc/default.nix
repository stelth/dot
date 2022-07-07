{ config, pkgs, lib, ... }:
let
  nvim-surround = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-surround";
    version = "2022-07-07";
    src = pkgs.fetchFromGitHub {
      owner = "kylechui";
      repo = "nvim-surround";
      rev = "1e308812e9bf9b98c4cf5fa7500b569385a19f96";
      sha256 = "sha256-dgC1ZdV/IWEYQTn66jDFF2H71iTZYwZMLrzgYrFBFcc=";
    };
    meta.homepage = "https://github.com/kylechui/nvim-surround";
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
        plugin = nvim-autopairs;
        file = ./autopairs.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-notify;
        file = ./notify.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-surround;
        file = ./surround.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = undotree;
        file = ./undotree.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = vim-matchup;
        file = ./vim-matchup.lua;
      })
    ];
  };
}
