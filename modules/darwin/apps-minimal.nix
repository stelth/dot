{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "1password-beta"
      "avibrazil-rdm"
      "firefox"
      "github"
      "google-chrome"
      "hammerspoon"
      "karabiner-elements"
      "keepingyouawake"
      "slack"
    ];
    masApps = { "Amphetamine" = 937984704; };
  };
}
