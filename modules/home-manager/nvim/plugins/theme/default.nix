{ config, lib, pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins;
      [
        (config.lib.vimUtils.pluginWithCfg {
          plugin = tokyonight-nvim;
          file = ./tokyonight.lua;
        })
      ];
  };
}
