{ config, pkgs, lib, ... }: {
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
