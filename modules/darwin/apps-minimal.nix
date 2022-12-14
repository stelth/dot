{
  config,
  lib,
  pkgs,
  ...
}: {
  homebrew = {
    casks = [
      "1password-beta"
      "avibrazil-rdm"
      "google-chrome"
      "hammerspoon"
      "kitty"
    ];
    masApps = {
      "BetterSnapTool" = 417375580;
    };
  };
}
