{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./plugins];

  lib.vimUtils = rec {
    wrapLuaConfig = luaConfig: ''
      lua<<EOF
      ${builtins.readFile luaConfig}
      EOF
    '';

    pluginWithCfg = plugin: {
      inherit plugin;
      config = builtins.readFile (./. + "/plugins/${plugin.pname}.lua");
      type = "lua";
    };
  };

  xdg.configFile = {
    "nvim/lua" = {
      recursive = true;
      source = ./nvim;
    };
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [fd tree-sitter];

    extraConfig = ''
      ${config.lib.vimUtils.wrapLuaConfig ./settings.lua}
      ${config.lib.vimUtils.wrapLuaConfig ./keymaps.lua}
    '';
  };
}
