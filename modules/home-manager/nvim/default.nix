{ config, pkgs, lib, ... }: {
  imports = [ ./plugins ];

  lib.vimUtils = rec {
    wrapLuaConfig = luaConfig: ''
      lua<<EOF
      ${builtins.readFile luaConfig}
      EOF
    '';

    readVimConfigRaw = builtins.readFile;

    readVimConfig = file: ''
      ${readVimConfigRaw file}
    '';

    configType = file:
      if (lib.strings.hasSuffix ".lua" (builtins.toString file)) then
        "lua"
      else
        "vimL";

    pluginWithCfg = { plugin, file }: {
      inherit plugin;
      type = configType file;
      config = readVimConfig file;
    };
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
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
