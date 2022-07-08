{ config, pkgs, lib, ... }:
let
  nvim-surround = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-surround";
    version = "2022-07-07";
    src = pkgs.fetchFromGitHub {
      owner = "kylechui";
      repo = "nvim-surround";
      rev = "cf27dc456860878256bee9e83d42c6c425ef1dcb";
      sha256 = "sha256-gtpx2TbHmXNjJ1lUuolCBN2BVNkAY9hdgdZLQIpDp/Q=";
    };
    meta.homepage = "https://github.com/kylechui/nvim-surround";
  };
  leap-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "leap-nvim";
    version = "2022-07-05";
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
