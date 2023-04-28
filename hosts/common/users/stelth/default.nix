{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.stelth = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "audio"
        "video"
      ]
      ++ ifTheyExist [
        "networkmanager"
        "libvirtd"
      ];

    hashedPassword = "$6$mwlr.3ZwTZHQDLHS$gCnJwFaZuwt7qN2qWYkkuBgdbBA/FpedYz09WKZm2BwnRf/JpEzb0rCLlksnNFkd2wUduPgn7b.DMp1PcW1yT.";

    packages = [pkgs.home-manager];
  };

  home-manager.users.stelth = import home/${config.networking.hostName}.nix;

  security.pam.services = {swaylock = {};};
}
