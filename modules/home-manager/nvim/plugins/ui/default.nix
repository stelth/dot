{ config, lib, pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin = kanagawa-nvim;
        file = ./kanagawa.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = lualine-nvim;
        file = ./lualine.lua;
      })
      nvim-web-devicons
    ];
  };
}
