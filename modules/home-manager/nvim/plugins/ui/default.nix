{ config, lib, pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin = kanagawa-nvim;
        file = ./kanagawa.lua;
      })
      nvim-web-devicons
    ];
  };
}
