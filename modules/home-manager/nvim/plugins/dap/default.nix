{ config, pkgs, lib, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-dap;
        file = ./dapadapters.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-dap-ui;
        file = ./dapui.lua;
      })
      nvim-dap-virtual-text
      telescope-dap-nvim
    ];
  };
}
