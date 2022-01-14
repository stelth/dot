{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "1password-beta"
      "avibrazil-rdm"
      "cyberduck"
      "discord"
      "firefox"
      "google-chrome"
      "hammerspoon"
      "karabiner-elements"
      "slack"
      "spotify"
      "twitch"
    ];
    masApps = { "Amphetamine" = 937984704; };
  };
}
