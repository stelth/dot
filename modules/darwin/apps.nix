{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "1password-beta"
      "avibrazil-rdm"
      "brave-browser"
      "cyberduck"
      "discord"
      "firefox"
      "hammerspoon"
      "karabiner-elements"
      "slack"
      "spotify"
      "twitch"
    ];
    masApps = { "Amphetamine" = 937984704; };
  };
}
