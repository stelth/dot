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
      "temurin8"
      "temurin11"
      "twitch"
    ];
    masApps = { "Amphetamine" = 937984704; };
  };
}
