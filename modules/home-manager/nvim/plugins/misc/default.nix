{ config, pkgs, lib, ... }:
let
  nvim-surround = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-surround";
    version = "2022-07-07";
    src = pkgs.fetchFromGitHub {
      owner = "kylechui";
      repo = "nvim-surround";
      rev = "1d5a090d79bc4c6242116427c4372b7a0633276d";
      sha256 = "sha256-lyju4px//HVapoXeOrr8ZESm3ODnKBj+cSjUCQYwTS4=";
    };
    meta.homepage = "https://github.com/kylechui/nvim-surround";
  };
  leap-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "leap-nvim";
    version = "2022-07-05";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap.nvim";
      rev = "1bb1fec369b1e9ae96e6ff1b829ea9272c51f844";
      sha256 = "sha256-dH0v1D5q5OlMLA/omTDMb/taKyIgQ5VfVMYXJ609k/k=";
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
      vim-repeat
    ];
  };
}
