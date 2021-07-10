{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    global = {
      brewfile = true;
      noLock = true;
    };

    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-versions"
      "nextdns/homebrew-tap"
    ];

    brews = [
      "fnm"
      "mas"
      "efm-langserver"
    ];

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
      "ubersicht"
    ];
  };
}
