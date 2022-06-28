{ config, pkgs, lib, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin = telescope-file-browser-nvim;
        file = ./filebrowser.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = telescope-nvim;
        file = ./telescope.lua;
      })
    ];
  };
}
