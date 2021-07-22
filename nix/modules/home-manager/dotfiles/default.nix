{ config, pkgs, ... }:
{

  home.file = {
    hammerspoon = {
      source = ./hammerspoon;
      target = ".hammerspoon";
      recursive = true;
    };
  };
  xdg.enable = true;
  xdg.configFile = {
    "nixpkgs/config.nix" = {
      source = ../../config.nix;
    };
    karabiner = {
      source = ./karabiner;
      recursive = true;
    };
    skhd = {
      source = ./skhd;
      recursive = true;
    };
    ssh = {
      source = ./ssh;
      recursive = true;
    };
  };
}
