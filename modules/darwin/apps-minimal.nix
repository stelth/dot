{ config, lib, pkgs, ... }: {
  homebrew = {
    casks =
      [ "1password-beta" "avibrazil-rdm" "firefox" "hammerspoon" "kitty" ];
    masApps = { };
  };
}
