{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./plugins.nix];

  xdg.configFile = {
    "nvim/lua" = {
      recursive = true;
      source = ./lua;
    };
    "nvim/ftplugin" = {
      recursive = true;
      source = ./ftplugin;
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
      lua<<EOF
      require('settings')
      EOF
    '';
  };
}
