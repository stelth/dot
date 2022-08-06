{ config, lib, pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin = fine-cmdline-nvim;
        file = ./fine-cmdline.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = kanagawa-nvim;
        file = ./kanagawa.lua;
      })
      nvim-web-devicons
      (config.lib.vimUtils.pluginWithCfg {
        plugin = staline-nvim;
        file = ./staline.lua;
      })
    ];
  };
}
