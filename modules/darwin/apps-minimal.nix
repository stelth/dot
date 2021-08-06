{ config, lib, pkgs, ... }:
{
  homebrew = {
    casks = [
      "1password"
      "avibrazil-rdm"
      "github"
      "google-chrome"
      "hammerspoon"
      "karabiner-elements"
      "keepingyouawake"
      "mactex-no-gui"
      "slack"
    ];
    brews = [
      "efm-langserver"
    ];
    masApps = {
      "Amphetamine" = 937984704;
    };
  };
}
