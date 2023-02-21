{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./plugins.nix];

  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim_configurable.override {
      guiSupport = "no";
      darwinSupport = true;
    };
  };
}
