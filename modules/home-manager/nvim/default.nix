{ config, pkgs, lib, ... }: {
  imports = [ ./plugins ];

  lib.vimUtils = rec {
    wrapLuaConfig = luaConfig: ''
      lua<<EOF
      ${luaConfig}
      EOF
    '';

    readVimConfigRaw = file:
      if (lib.strings.hasSuffix ".lua" (builtins.toString file)) then
        wrapLuaConfig (builtins.readFile file)
      else
        builtins.readFile file;

    readVimConfig = file: ''
      ${readVimConfigRaw file}
    '';
    pluginWithCfg = { plugin, file }: {
      inherit plugin;
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

    extraConfig = ''
      ${config.lib.vimUtils.readVimConfig ./settings.lua}
      ${config.lib.vimUtils.readVimConfig ./keymaps.lua}
    '';
  };
}
