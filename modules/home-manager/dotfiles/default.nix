{ config, pkgs, lib, ... }: {

  home.file = {
    hammerspoon = {
      source = ./hammerspoon;
      target = ".hammerspoon";
      recursive = true;
    };
  };
  xdg.enable = true;
  xdg.configFile = {
    "nixpkgs/config.nix" = { source = ../../config.nix; };
    karabiner = {
      source = ./karabiner;
      recursive = true;
    };
    yabai = lib.mkIf pkgs.stdenvNoCC.isDarwin {
      source = ./yabai;
      recursive = true;
    };
  };
}
