{ config, lib, pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins;
      [
        (config.lib.vimUtils.pluginWithCfg {
          plugin = gruvbox-nvim;
          file = ./gruvbox.lua;
        })
      ];
  };
}
