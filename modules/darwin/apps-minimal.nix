{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "1password-beta"
      "avibrazil-rdm"
      "google-chrome"
      "hammerspoon"
      "karabiner-elements"
      "kitty"
    ];
    masApps = { };
  };
}
