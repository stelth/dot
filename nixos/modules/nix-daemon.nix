{
  lib,
  config,
  pkgs,
  ...
}: {
  # this extends srvos's common settings
  nix = {
    gc = {
      automatic = true;
      dates = "03:15";
      options = "--delete-older-than 10d";
    };
    package = pkgs.nixVersions.unstable;

    settings = {
      # for nix-direnv
      keep-outputs = true;
      keep-derivations = true;

      # in zfs we trust
      fsync-metadata = lib.boolToString (!config.boot.isContainer or config.fileSystems."/".fsType != "zfs");
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = ["@wheel" "root"];

      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
      auto-allocate-uids = true;
      system-features = lib.mkDefault ["uid-range"];
      experimental-features = ["repl-flake" "impure-derivations" "auto-allocate-uids" "cgroups"];
    };
  };

  programs.command-not-found.enable = false;
}
