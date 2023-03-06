{
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
    clangd = {
      source = ./clangd;
      target = "Library/Preferences/clangd";
      recursive = true;
    };
  };
  xdg.enable = true;
  xdg.configFile = {
    "nixpkgs/config.nix" = {source = ../../config.nix;};
  };
}
