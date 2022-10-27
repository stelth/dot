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
      "brave-browser"
      "hammerspoon"
      "kitty"
    ];
    masApps = {
      "BetterSnapTool" = 417375580;
    };
  };
}
