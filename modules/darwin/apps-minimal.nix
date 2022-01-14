{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "1password-beta"
      "avibrazil-rdm"
      "brave-browser"
      "firefox"
      "github"
      "hammerspoon"
      "karabiner-elements"
      "keepingyouawake"
      "slack"
    ];
    masApps = { "Amphetamine" = 937984704; };
  };
}
