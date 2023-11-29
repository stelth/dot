{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./plugins.nix];

  xdg.configFile = {
    "nvim/lua" = {
      recursive = true;
      source = ./lua;
    };
  };

  home = lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
    persistence = {
      "/persist/home/stelth".directories = [
        ".local/share/nvim"
        ".local/state/nvim"
      ];
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [fd tree-sitter];

    extraLuaConfig = ''
      require('settings')
    '';
  };
}
