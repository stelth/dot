{ config, lib, pkgs, ... }:
{
  homebrew = {
    casks = [
      "avibrazil-rdm"
      "discord"
      "github"
      "google-chrome"
      "hammerspoon"
      "karabiner-elements"
      "mactex-no-gui"
      "slack"
      "spotify"
      "twitch"
    ];
    brews = [
      "efm-langserver"
    ];
    masApps = {
      "Amphetamine" = 937984704;
    };
  };
}
