{
  config,
  pkgs,
  lib,
  ...
}: {
  home.file = {
    hammerspoon = lib.mkIf pkgs.stdenvNoCC.isDarwin {
      source = ./hammerspoon;
      target = ".hammerspoon";
      recursive = true;
    };
  };
  xdg.enable = true;
  xdg.configFile = {
    "nixpkgs/config.nix" = {source = ../../config.nix;};
    yabai = lib.mkIf pkgs.stdenvNoCC.isDarwin {
      source = ./yabai;
      recursive = true;
    };
    kitty = {
      source = ./kitty;
      recursive = true;
    };
  };
}
