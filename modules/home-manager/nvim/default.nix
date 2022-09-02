{ config, pkgs, lib, ... }: {
  imports = [ ./plugins ];

  lib.vimUtils = rec {
    wrapLuaConfig = luaConfig: ''
      lua<<EOF
      ${builtins.readFile luaConfig}
      EOF
    '';

    pluginWithCfg = plugin: config: {
      inherit plugin;
      inherit config;
      type = "lua";
    };

    pluginWithCfgFile = plugin:
      pluginWithCfg plugin
      (builtins.readFile (./. + "/plugins/${plugin.pname}.lua"));
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [ fd ];

    extraConfig = ''
      ${config.lib.vimUtils.wrapLuaConfig ./settings.lua}
      ${config.lib.vimUtils.wrapLuaConfig ./keymaps.lua}
    '';
  };
}
