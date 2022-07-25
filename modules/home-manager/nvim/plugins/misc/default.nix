{ config, pkgs, lib, ... }:
let
  nvim-surround = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-surround";
    version = "2022-07-13";
    src = pkgs.fetchFromGitHub {
      owner = "kylechui";
      repo = "nvim-surround";
      rev = "beea0fd11c4dafb66845914c6cfc705e46cc3207";
      sha256 = "sha256-Ns+DvLkiqMpg50OL0UtpurpgrCbh6jknZ/d9QTRQER4=";
    };
    meta.homepage = "https://github.com/kylechui/nvim-surround";
  };
  leap-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "leap-nvim";
    version = "2022-07-13";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap.nvim";
      rev = "1d1032feefb53d407c59ea37d80374d77f6f9f3b";
      sha256 = "sha256-rD8Z+/SkhMoMr5PtI7bkJFgEMz+nB6A09dDhlvG6oBY=";
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
