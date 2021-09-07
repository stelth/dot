{ config, lib, pkgs, ... }: {
  homebrew = {
    casks = [
      "1password-beta"
      "avibrazil-rdm"
      "firefox"
      "github"
      "hammerspoon"
      "karabiner-elements"
      "keepingyouawake"
      "mactex-no-gui"
      "slack"
    ];
    masApps = { "Amphetamine" = 937984704; };
  };
}
