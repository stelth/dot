{ config, lib, pkgs, ... }: {
  imports = [ ./apps-minimal.nix ];
  homebrew = {
    casks = [ "cyberduck" "discord" "firefox" "slack" "spotify" "twitch" ];
    masApps = { };
  };
}
