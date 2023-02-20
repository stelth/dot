{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./plugins.nix];

  programs.vim = {
    enable = true;
  };
}
