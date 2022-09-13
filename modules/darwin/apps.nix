{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./apps-minimal.nix];
  homebrew = {
    casks = [
      "cyberduck"
      "discord"
      "docker"
      "firefox-developer-edition"
      "slack"
      "spotify"
    ];
    masApps = {};
  };
}
