{
  lib,
  pkgs,
  ...
}: {
  imports = [./plugins.nix];

  xdg.configFile = {
    vim = {
      source = ./vim;
      target = "vim";
      recursive = true;
    };
  };

  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim_configurable.override {
      guiSupport = "no";
      darwinSupport = lib.mkIf pkgs.stdenvNoCC.isDarwin;
    };
    extraConfig = ''
      source ~/.config/vim/vimrc
    '';
  };
}
