{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "1password"
      "avibrazil-rdm"
      "discord"
      "firefox"
      "github"
      "google-chrome"
      "hammerspoon"
      "karabiner-elements"
      "mactex-no-gui"
      "slack"
      "spotify"
      "twitch"
    ];
    masApps = { "Amphetamine" = 937984704; };
  };
}
